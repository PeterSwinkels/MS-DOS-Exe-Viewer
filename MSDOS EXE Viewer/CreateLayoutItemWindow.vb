'This class's imports and settings.
Option Compare Binary
Option Explicit On
Option Infer Off
Option Strict On

Imports System
Imports System.Convert
Imports System.Drawing
Imports System.Environment
Imports System.Windows.Forms

'This class contains the window for creating layout items.
Public Class CreateLayoutItemWindow

   Private WithEvents ToolTip As New ToolTip  'Contains the tooltip.

   'This procedure initializes this window.
   Public Sub New()
      Try
         InitializeComponent()

         My.Application.ChangeCulture("en-US")

         With My.Computer.Screen.WorkingArea
            Me.Size = New Size(CInt(.Width / 2), CInt(.Height / 2))
         End With

         ToolTip.SetToolTip(AssemblyBox, "Press the P key to paste disassembly here. A new layout item will be placed onto the clipboard.")
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure handles the user's key strokes.
   Private Sub CreateLayoutItemWindow_KeyPress(sender As Object, e As KeyPressEventArgs) Handles MyBase.KeyPress
      Dim CodeLength As New Integer
      Dim Offset As New Integer?

      Try
         If e.KeyChar.ToString().ToUpper() = "P" Then
            AssemblyBox.Text = Clipboard.GetText()

            If AssemblyBox.Text.Length > 0 Then
               For Each Line As String In AssemblyBox.Text.Split(NewLine.ToCharArray())
                  If Line.Contains(" "c) Then
                     If Offset Is Nothing AndAlso Line.Contains(" "c) Then
                        Offset = ToInt32(Line.Substring(0, Line.IndexOf(" "c)).Trim(), fromBase:=16)
                     End If
                     Line = Line.Substring(Line.IndexOf(" "c)).Trim()
                     If Line.Contains(" "c) Then
                        Line = Line.Substring(0, Line.IndexOf(" "c)).Trim()
                        CodeLength += (Line.Length \ 2)
                     End If
                  End If
               Next Line

               Clipboard.SetText($"{Offset};{CodeLength};code;comment")
            End If
         End If
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub
End Class