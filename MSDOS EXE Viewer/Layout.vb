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

'This module contains the executable layout related procedures.
Public Module LayoutModule
   'This enumeration lists the layout item properties.
   Private Enum LayoutPropertiesE As Integer
      Position      'Position.
      Length        'Length.
      Type          'Type.
      Description   'Description.
   End Enum

   'This structure defines a layout item.
   Public Structure LayoutItemStr
      Public Position As Integer     'Defines an item's position.
      Public Length As Integer       'Defines an item's length.
      Public Type As String          'Defines an item's type.
      Public Description As String   'Defines an item's comment.
   End Structure

   Public LayoutItems As New List(Of LayoutItemStr)   'Contains the layout items.

   'This procedure returns the data specified by the specified layout item.
   Public Function GetLayoutData(Data() As Byte, LayoutItem As LayoutItemStr) As String
      Try
         Dim Description As String = Nothing
         Dim Disassembly As String = Nothing
         Dim LayoutData As New StringBuilder
         Dim Position As New Integer

         With LayoutItem
            If .Position <= Data.Length AndAlso .Position + .Length < Data.Length Then
               Select Case .Type.Trim().ToLower()
                  Case "code"
                     Position = .Position
                     Do While Position <= .Position + .Length
                        Disassembly = Disassembler.Disassemble(Data, Position)
                        Description = GetGlobalDescription(Disassembly)
                        If Description = Nothing Then
                           Description = GetNearCallDescription(Disassembly)
                           If Not Description = Nothing Then
                              Disassembly = $"{Disassembly} {ASSEMBLY_COMMENT} {Description}"
                           End If
                        Else
                           Disassembly = $"{Disassembly} {ASSEMBLY_COMMENT} {Description}"
                        End If
                        LayoutData.Append($"{Position:X8} {Disassembly}{NewLine}")
                     Loop
                  Case "text"
                     LayoutData.Append(Escape(New String((From Item In Data Skip .Position Take .Length Select ToChar(Item)).ToArray())))
               End Select
            End If
         End With

         Return LayoutData.ToString()
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try

      Return ""
   End Function

   'This procedure loads the specified layout file.
   Public Sub LoadLayout(LayoutFile As String)
      Try
         Dim Lines As New List(Of String)(File.ReadAllLines(LayoutFile))
         Dim Properties() As String = {}

         LayoutItems = New List(Of LayoutItemStr)

         Lines.RemoveAt(0)
         Lines.RemoveAt(0)
         For Each Line As String In Lines
            If Not Line.Trim() = Nothing Then
               Properties = Line.Split(DELIMITER)
               LayoutItems.Add(New LayoutItemStr With {.Description = Properties(LayoutPropertiesE.Description), .Length = ToInt32(Properties(LayoutPropertiesE.Length)), .Position = ToInt32(Properties(LayoutPropertiesE.Position)), .Type = Properties(LayoutPropertiesE.Type)})
            End If
         Next Line
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub
End Module
