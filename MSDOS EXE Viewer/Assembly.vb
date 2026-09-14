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
Imports System.Reflection
Imports System.Text

'This module contains the assembly parsing procedures.
Public Module AssemblyModule
   Public ASSEMBLY_COMMENT As Char = ";"c              'Defines an assembly comment.
   Private Const GLOBAL_PREFIX As String = "[0x"        'Defines a global's prefix.
   Private Const GLOBAL_SUFFIX As Char = "]"c           'Defines a global's suffix.
   Private Const NEAR_CALL As String = "CALL NEAR 0x"   'Defines a near call.

   'This procedure returns any global defined in the specified assembly code.
   Private Function GetGlobal(Disassembly As String) As Integer?
      Try
         Dim Address As New Integer?
         Dim Hexadecimal As String = Nothing

         If Disassembly.Contains(GLOBAL_PREFIX) AndAlso Disassembly.Contains(GLOBAL_SUFFIX) Then
            Hexadecimal = Disassembly.Substring(Disassembly.IndexOf(GLOBAL_PREFIX) + GLOBAL_PREFIX.Length)
            Hexadecimal = Hexadecimal.Substring(0, Hexadecimal.IndexOf(GLOBAL_SUFFIX))
            Address = ToInt32(Hexadecimal, fromBase:=16)
         End If

         Return Address
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try

      Return Nothing
   End Function

   'This procedure returns the description for any global defined in the specified assembly code.
   Public Function GetGlobalDescription(Disassembly As String) As String
      Try
         Dim Address As Integer? = GetGlobal(Disassembly)
         Dim Description As String = Nothing
         Dim Index As New Integer

         If Address IsNot Nothing Then
            Index = Globals.FindIndex(Function(Item) Item.Address = Address.Value)
            If Index >= 0 Then
               Description = Globals(Index).Description
            End If
         End If

         Return Description
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try

      Return Nothing
   End Function

   'This procedure returns the description for any near call defined in the specified assembly code.
   Public Function GetNearCallDescription(Disassembly As String) As String
      Try
         Dim Description As String = Nothing
         Dim Index As New Integer
         Dim Target As New Integer

         If Disassembly.StartsWith(NEAR_CALL) Then
            Target = ToInt32(Disassembly.Substring(NEAR_CALL.Length), fromBase:=16)
            Index = LayoutItems.FindIndex(Function(Item) Item.Position = Target)
            If Index >= 0 Then
               Description = LayoutItems(Index).Description
            End If
         End If

         Return Description
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try

      Return Nothing
   End Function
End Module