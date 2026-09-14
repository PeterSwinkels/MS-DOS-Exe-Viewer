'This module's imports and settings.
Option Compare Binary
Option Explicit On
Option Infer Off
Option Strict On

Imports System
Imports System.Collections.Generic
Imports System.Convert
Imports System.IO

'This module contains the executable globals related procedures.
Public Module GlobalsModule
   'This enumeration lists the globals' properties.
   Private Enum GlobalPropertiesE As Integer
      Address       'Address.
      Description   'Description.
   End Enum

   'This structure defines the globals.
   Public Structure GlobalStr
      Public Address As Integer      'Defines the global's address.
      Public Description As String   'Defines the global's description.
   End Structure

   Public Globals As New List(Of GlobalStr)   'Contains the list of globals.

   'This procedure loads the specified globals file.
   Public Sub LoadGlobals(GlobalsFile As String)
      Try
         Dim Lines As New List(Of String)(File.ReadAllLines(GlobalsFile))
         Dim Properties() As String = {}

         Globals = New List(Of GlobalStr)

         Lines.RemoveAt(0)
         Lines.RemoveAt(0)
         For Each Line As String In Lines
            If Not Line.Trim() = Nothing Then
               Properties = Line.Split(DELIMITER)
               Globals.Add(New GlobalStr With {.Address = ToInt32(Properties(GlobalPropertiesE.Address), fromBase:=16), .Description = Properties(GlobalPropertiesE.Description)})
            End If
         Next Line
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub
End Module
