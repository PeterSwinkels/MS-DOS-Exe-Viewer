'This module's imports and settings.
Option Compare Binary
Option Explicit On
Option Infer Off
Option Strict On

Imports System
Imports System.Collections.Generic
Imports System.Convert
Imports System.Environment
Imports System.IO
Imports System.Linq
Imports System.Text
Imports System.Windows.Forms

'This module contains this program's core procedures.
Public Module CoreModule
   'This structure defines an MS-DOS executable.
   Public Structure MSDOSEXEStr
      Public Data() As Byte   'Defines the executable's binary data.
      Public Path As String   'Defines the executable's path.
   End Structure

   Public DELIMITER As Char = ";"c                            'Defines the layout property delimiter.
   Private Const HEADER_SIZE As Integer = &H1C%                'Defines an MS-DOS executable header's size.
   Private Const PROJECT_FILE_LABEL As String = "[MSDOSEXE]"   'Defines the project file label.

   Private ReadOnly TAB As Char = ToChar(&H9%)   'Defines the tab character.

   Public WithEvents Disassembler As New DisassemblerClass   'Contains the disassembler.

   Public MSDOSEXE As New MSDOSEXEStr With {.Data = {}, .Path = ""}   'Contains an MS-DOS executable.

   'This procedure displays the message describing the specified exception.
   Public Sub DisplayException(ExceptionO As Exception)
      Try
         If MessageBox.Show(ExceptionO.Message, My.Application.Info.Title, MessageBoxButtons.OKCancel, MessageBoxIcon.Error) = DialogResult.Cancel Then
            Application.Exit()
         End If
      Catch
         [Exit](0)
      End Try
   End Sub

   'This procedure returns the specified text with the non-displayable characters as escape sequences.
   Public Function Escape(Text As String, Optional EscapeCharacter As Char = "/"c) As String
      Try
         Dim Escaped As New StringBuilder

         For Each Character As Char In Text.ToCharArray()
            If Character = EscapeCharacter Then
               Escaped.Append(New String(EscapeCharacter, 2))
            ElseIf Character = TAB OrElse Character >= " "c Then
               Escaped.Append(Character)
            Else
               Escaped.Append($"{EscapeCharacter}{ToByte(Character):X2}")
            End If
         Next Character

         Return Escaped.ToString()
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try

      Return ""
   End Function

   'This procedure returns the specified executable header's content.
   Public Function GetEXEHeader(Data() As Byte) As String
      Try
         Dim Header As New StringBuilder
         Dim RelocationCount As Integer = BitConverter.ToInt16(Data, &H6%)

         Header.Append($"Signature               0x00  {ToChar(Data(&H0%))}{ToChar(Data(&H1%))}{NewLine}")
         Header.Append($"Last page size          0x02  0x{BitConverter.ToInt16(Data, &H2%):X2}{NewLine}")
         Header.Append($"File size **            0x04  0x{BitConverter.ToInt16(Data, &H4%):X2}{NewLine}")
         Header.Append($"Relocation count        0x06  0x{RelocationCount:X2}{NewLine}")
         Header.Append($"Header size *           0x08  0x{BitConverter.ToInt16(Data, &H8%):X2}{NewLine}")
         Header.Append($"Required memory *       0x0A  0x{BitConverter.ToInt16(Data, &HA%):X2}{NewLine}")
         Header.Append($"Preferred memory *      0x0C  0x{BitConverter.ToInt16(Data, &HC%):X2}{NewLine}")
         Header.Append($"Initial SS              0x0E  0x{BitConverter.ToInt16(Data, &HE%):X2}{NewLine}")
         Header.Append($"Initial SP              0x10  0x{BitConverter.ToInt16(Data, &H10%):X2}{NewLine}")
         Header.Append($"PGM checksum            0x12  0x{BitConverter.ToInt16(Data, &H12%):X2}{NewLine}")
         Header.Append($"Initial IP              0x14  0x{BitConverter.ToInt16(Data, &H14%):X2}{NewLine}")
         Header.Append($"Unrelocated CS          0x16  0x{BitConverter.ToInt16(Data, &H16%):X2}{NewLine}")
         Header.Append($"Relocation table offset 0x18  0x{BitConverter.ToInt16(Data, &H18%):X2}{NewLine}")
         Header.Append($"Overlay number          0x1A  0x{BitConverter.ToInt16(Data, &H1A%):X2}{NewLine}")
         Header.Append(NewLine)
         Header.Append($"* = Size specified in paragraphs of 0x10 bytes.{NewLine}")
         Header.Append($"** = Size specified in pages of 0x200 bytes.{NewLine}")
         Header.Append($"{NewLine}Relocation items:{NewLine}")

         For Position As Integer = HEADER_SIZE To HEADER_SIZE + ((RelocationCount * &H4%) - &H4%) Step &H4%
            Header.Append($"{BitConverter.ToInt32(Data, Position):X4}{NewLine}")
         Next Position

         Return Header.ToString()
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try

      Return ""
   End Function

   'This procedure loads the specified project file.
   Public Sub LoadProject(ProjectPath As String)
      Try
         Dim BasePath As String = Path.GetDirectoryName(ProjectPath)
         Dim ExeSize As New Integer?
         Dim FullPath As String = Nothing
         Dim Header As String = Nothing
         Dim Lines As New List(Of String)(From Line In File.ReadAllLines(ProjectPath) Where Not (Line.Trim() = Nothing OrElse Line.StartsWith("#"c)))
         Dim Value As New Integer

         If Lines.First().Trim().ToUpper() = PROJECT_FILE_LABEL Then
            Lines.RemoveAt(0)
            For Each ProjectItem As String In Lines
               If ProjectItem.ToUpper.Trim().StartsWith("EXESIZE = ") Then
                  ProjectItem = ProjectItem.Substring(ProjectItem.IndexOf("="c) + 1).Trim()
                  If Integer.TryParse(ProjectItem, Value) Then
                     ExeSize = Value
                  Else
                     MessageBox.Show("Invalid executable size.", My.Application.Info.Title, MessageBoxButtons.OK, MessageBoxIcon.Error)
                  End If
               Else
                  FullPath = Path.Combine(BasePath.Trim(), ProjectItem.Trim())
                  If FullPath.Trim().ToLower().EndsWith(".csv") Then
                     Header = File.ReadAllLines(FullPath).First().Trim().ToUpper()
                     Header = Header.Substring(0, Header.IndexOf(DELIMITER))
                     Select Case Header
                        Case "GLOBALS"
                           LoadGlobals(FullPath)
                        Case "LAYOUT"
                           LoadLayout(FullPath)
                        Case Else
                           MessageBox.Show($"Unsupported file type ""{FullPath}"".", My.Application.Info.Title, MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                     End Select
                  ElseIf FullPath.ToLower().EndsWith(".exe") Then
                     MSDOSEXE = New MSDOSEXEStr With {.Data = File.ReadAllBytes(FullPath), .Path = FullPath}
                  ElseIf Not FullPath.Trim() = Nothing Then
                     MessageBox.Show($"Unsupported file in project ""{FullPath}"".", My.Application.Info.Title, MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                  End If
               End If
            Next ProjectItem
         Else
            MessageBox.Show("This is not a project file.", My.Application.Info.Title, MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
         End If

         If MSDOSEXE.Data.Any Then
            If ExeSize IsNot Nothing AndAlso Not MSDOSEXE.Data.Length = ExeSize Then
               MessageBox.Show($"Expected executable size: {ExeSize}. Actual size: {MSDOSEXE.Data.Length}.", My.Application.Info.Title, MessageBoxButtons.OK, MessageBoxIcon.Warning)
            End If
         Else
            MessageBox.Show("No executable has been loaded.", My.Application.Info.Title, MessageBoxButtons.OK, MessageBoxIcon.Warning)
         End If
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure returns information about this program.
   Public Function ProgramInformation() As String
      Try
         With My.Application.Info
            Return $"{ .Title} v{ .Version} - by: { .CompanyName}, { .Copyright}"
         End With
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try

      Return Nothing
   End Function
End Module
