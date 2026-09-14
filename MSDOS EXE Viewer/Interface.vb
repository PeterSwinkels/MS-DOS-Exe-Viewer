'This class's imports and settings.
Option Compare Binary
Option Explicit On
Option Infer Off
Option Strict On

Imports System
Imports System.Drawing
Imports System.Environment
Imports System.Linq
Imports System.Windows.Forms

'This class contains this program's main interface window.
Public Class InterfaceWindow
   Private LoadProjectDialog As New OpenFileDialog With {.CheckFileExists = True, .CheckPathExists = True, .Filter = "Project files (*.mak)|*.mak", .FilterIndex = 0, .Multiselect = False, .RestoreDirectory = False}   'Contains the load project dialog.

   Private WithEvents ToolTip As New ToolTip         'Contains the tooltip.

   'This procedure initializes this window.
   Public Sub New()
      Try
         InitializeComponent()

         My.Application.ChangeCulture("en-US")

         With My.Computer.Screen.WorkingArea
            Me.Size = New Size(CInt(.Width / 1.1), CInt(.Height / 1.1))
         End With

         Me.Text = ProgramInformation()

         ToolTip.SetToolTip(DataBox, "Drag a *.mak (project file) into this field to view it.")

         If GetCommandLineArgs().Count = 2 Then
            LoadProject(GetCommandLineArgs().Last)

            LayoutItemsBox.Items.Clear()
            LayoutItemsBox.Items.AddRange((From Item In LayoutItems Select Item.Description).ToArray())
            If LayoutItemsBox.Items.Count > 0 Then
               LayoutItemsBox.SelectedIndex = 0
            End If
            If MSDOSEXE.Data.Length > 0 Then
               InformationMenu.PerformClick()
            End If
         End If
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure opens the window for creating layout items.
   Private Sub CreateItemMenu_Click(sender As Object, e As EventArgs) Handles CreateItemMenu.Click
      Try
         CreateLayoutItemWindow.ShowDialog()
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure gives the command to load the file dropped into the data box.
   Private Sub DataBox_DragDrop(sender As Object, e As DragEventArgs) Handles DataBox.DragDrop
      Try
         If e.Data.GetDataPresent(DataFormats.FileDrop) Then
            ProjectLoad(DirectCast(e.Data.GetData(DataFormats.FileDrop), String()).First())
         End If
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure handles objects being dragged into the data box.
   Private Sub DataBox_DragEnter(sender As Object, e As DragEventArgs) Handles DataBox.DragEnter
      Try
         If e.Data.GetDataPresent(DataFormats.FileDrop) Then
            e.Effect = DragDropEffects.All
         End If
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure displays the current MS-DOS executable's header.
   Private Sub HeaderMenu_Click(sender As Object, e As EventArgs) Handles HeaderMenu.Click
      Try
         DataBox.Text = GetEXEHeader(MSDOSEXE.Data)
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure displays the current MS-DOS executable's general information.
   Private Sub InformationMenu_Click(sender As Object, e As EventArgs) Handles InformationMenu.Click
      Try
         DataBox.Text = $"Path: ""{MSDOSEXE.Path}""{NewLine}Size: {MSDOSEXE.Data.Length} bytes."
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure adjusts the window to its new size.
   Private Sub InterfaceWindow_Load(sender As Object, e As EventArgs) Handles MyBase.Resize
      Try
         LayoutItemsBox.Width = (Me.ClientRectangle.Width \ 2)
         LayoutPropertiesLabel.Left = LayoutItemsBox.Left + LayoutItemsBox.Width
         LayoutPropertiesLabel.Width = Me.ClientRectangle.Width - LayoutPropertiesLabel.Left
      Catch
      End Try
   End Sub

   'This procedure displays the selected layout item's properties.
   Private Sub LayoutItemsBox_SelectedIndexChanged(sender As Object, e As EventArgs) Handles LayoutItemsBox.SelectedIndexChanged
      Try
         With LayoutItems(LayoutItemsBox.SelectedIndex)
            LayoutPropertiesLabel.Text = $"Type: ""{ .Type}"" Position: { .Position} Length: { .Length}"
         End With

         DataBox.Text = GetLayoutData(MSDOSEXE.Data, LayoutItems(LayoutItemsBox.SelectedIndex))
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procedure displays a dialog with which the user can select a project to load.
   Private Sub LoadProjectMenu_Click(sender As Object, e As EventArgs) Handles LoadProjectMenu.Click
      Try
         If LoadProjectDialog.ShowDialog = DialogResult.OK Then
            ProjectLoad(LoadProjectDialog.FileName)
         End If
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub

   'This procudure resets the interface and gives the command to load a project.
   Private Sub ProjectLoad(ProjectPath As String)
      Try
         LoadProject(ProjectPath)

         LayoutItemsBox.Items.Clear()
         LayoutItemsBox.Items.AddRange((From Item In LayoutItems Select Item.Description).ToArray())
         If LayoutItemsBox.Items.Count > 0 Then
            LayoutItemsBox.SelectedIndex = 0
         End If
         If MSDOSEXE.Data.Length > 0 Then
            InformationMenu.PerformClick()
         End If
      Catch ExceptionO As Exception
         DisplayException(ExceptionO)
      End Try
   End Sub
End Class