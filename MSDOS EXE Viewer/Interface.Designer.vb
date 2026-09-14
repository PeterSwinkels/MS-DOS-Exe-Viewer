Imports System.Windows.Forms

<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class InterfaceWindow
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.DataBox = New System.Windows.Forms.TextBox()
        Me.MenuBar = New System.Windows.Forms.MenuStrip()
        Me.ExecutableMainMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.HeaderMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.InformationMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.LayoutMainMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.CreateItemMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.LayoutLabel = New System.Windows.Forms.Label()
        Me.LayoutItemsBox = New System.Windows.Forms.ComboBox()
        Me.LayoutPropertiesLabel = New System.Windows.Forms.Label()
        Me.ProjectMainMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.LoadProjectMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.MenuBar.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataBox
        '
        Me.DataBox.AllowDrop = True
        Me.DataBox.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.DataBox.BackColor = System.Drawing.SystemColors.Window
        Me.DataBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.DataBox.Font = New System.Drawing.Font("Consolas", 13.8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataBox.Location = New System.Drawing.Point(0, 51)
        Me.DataBox.Margin = New System.Windows.Forms.Padding(2)
        Me.DataBox.Multiline = True
        Me.DataBox.Name = "DataBox"
        Me.DataBox.ReadOnly = True
        Me.DataBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.DataBox.Size = New System.Drawing.Size(600, 315)
        Me.DataBox.TabIndex = 0
        '
        'MenuBar
        '
        Me.MenuBar.ImageScalingSize = New System.Drawing.Size(20, 20)
        Me.MenuBar.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ProjectMainMenu, Me.ExecutableMainMenu, Me.LayoutMainMenu})
        Me.MenuBar.Location = New System.Drawing.Point(0, 0)
        Me.MenuBar.Name = "MenuBar"
        Me.MenuBar.Padding = New System.Windows.Forms.Padding(4, 2, 0, 2)
        Me.MenuBar.Size = New System.Drawing.Size(600, 24)
        Me.MenuBar.TabIndex = 1
        Me.MenuBar.Text = "MenuStrip1"
        '
        'ExecutableMainMenu
        '
        Me.ExecutableMainMenu.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.HeaderMenu, Me.InformationMenu})
        Me.ExecutableMainMenu.Name = "ExecutableMainMenu"
        Me.ExecutableMainMenu.Size = New System.Drawing.Size(75, 20)
        Me.ExecutableMainMenu.Text = "&Executable"
        '
        'HeaderMenu
        '
        Me.HeaderMenu.Name = "HeaderMenu"
        Me.HeaderMenu.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.H), System.Windows.Forms.Keys)
        Me.HeaderMenu.Size = New System.Drawing.Size(180, 22)
        Me.HeaderMenu.Text = "&Header"
        '
        'InformationMenu
        '
        Me.InformationMenu.Name = "InformationMenu"
        Me.InformationMenu.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.I), System.Windows.Forms.Keys)
        Me.InformationMenu.Size = New System.Drawing.Size(180, 22)
        Me.InformationMenu.Text = "&Information"
        '
        'LayoutMainMenu
        '
        Me.LayoutMainMenu.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.CreateItemMenu})
        Me.LayoutMainMenu.Name = "LayoutMainMenu"
        Me.LayoutMainMenu.Size = New System.Drawing.Size(55, 20)
        Me.LayoutMainMenu.Text = "&Layout"
        '
        'CreateItemMenu
        '
        Me.CreateItemMenu.Name = "CreateItemMenu"
        Me.CreateItemMenu.ShortcutKeys = CType(((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.Shift) _
            Or System.Windows.Forms.Keys.C), System.Windows.Forms.Keys)
        Me.CreateItemMenu.Size = New System.Drawing.Size(209, 22)
        Me.CreateItemMenu.Text = "&Create Item"
        '
        'LayoutLabel
        '
        Me.LayoutLabel.AutoSize = True
        Me.LayoutLabel.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.2!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LayoutLabel.Location = New System.Drawing.Point(9, 25)
        Me.LayoutLabel.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.LayoutLabel.Name = "LayoutLabel"
        Me.LayoutLabel.Size = New System.Drawing.Size(55, 17)
        Me.LayoutLabel.TabIndex = 2
        Me.LayoutLabel.Text = "Layout:"
        '
        'LayoutItemsBox
        '
        Me.LayoutItemsBox.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.2!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LayoutItemsBox.FormattingEnabled = True
        Me.LayoutItemsBox.Location = New System.Drawing.Point(62, 23)
        Me.LayoutItemsBox.Margin = New System.Windows.Forms.Padding(2)
        Me.LayoutItemsBox.Name = "LayoutItemsBox"
        Me.LayoutItemsBox.Size = New System.Drawing.Size(260, 25)
        Me.LayoutItemsBox.TabIndex = 1
        '
        'LayoutPropertiesLabel
        '
        Me.LayoutPropertiesLabel.AutoSize = True
        Me.LayoutPropertiesLabel.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.2!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LayoutPropertiesLabel.Location = New System.Drawing.Point(334, 23)
        Me.LayoutPropertiesLabel.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.LayoutPropertiesLabel.Name = "LayoutPropertiesLabel"
        Me.LayoutPropertiesLabel.Size = New System.Drawing.Size(0, 17)
        Me.LayoutPropertiesLabel.TabIndex = 4
        '
        'ProjectMainMenu
        '
        Me.ProjectMainMenu.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.LoadProjectMenu})
        Me.ProjectMainMenu.Name = "ProjectMainMenu"
        Me.ProjectMainMenu.Size = New System.Drawing.Size(56, 20)
        Me.ProjectMainMenu.Text = "&Project"
        '
        'LoadProjectMenu
        '
        Me.LoadProjectMenu.Name = "LoadProjectMenu"
        Me.LoadProjectMenu.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.L), System.Windows.Forms.Keys)
        Me.LoadProjectMenu.Size = New System.Drawing.Size(180, 22)
        Me.LoadProjectMenu.Text = "&Load Project"
        '
        'InterfaceWindow
        '
        Me.AllowDrop = True
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(600, 366)
        Me.Controls.Add(Me.LayoutPropertiesLabel)
        Me.Controls.Add(Me.LayoutItemsBox)
        Me.Controls.Add(Me.LayoutLabel)
        Me.Controls.Add(Me.DataBox)
        Me.Controls.Add(Me.MenuBar)
        Me.KeyPreview = True
        Me.MainMenuStrip = Me.MenuBar
        Me.Margin = New System.Windows.Forms.Padding(2)
        Me.Name = "InterfaceWindow"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.MenuBar.ResumeLayout(False)
        Me.MenuBar.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents DataBox As TextBox
    Friend WithEvents MenuBar As MenuStrip
    Friend WithEvents ExecutableMainMenu As ToolStripMenuItem
    Friend WithEvents HeaderMenu As ToolStripMenuItem
    Friend WithEvents InformationMenu As ToolStripMenuItem
    Friend WithEvents LayoutLabel As Label
    Friend WithEvents LayoutItemsBox As ComboBox
    Friend WithEvents LayoutPropertiesLabel As Label
    Friend WithEvents LayoutMainMenu As ToolStripMenuItem
    Friend WithEvents CreateItemMenu As ToolStripMenuItem
    Friend WithEvents ProjectMainMenu As ToolStripMenuItem
    Friend WithEvents LoadProjectMenu As ToolStripMenuItem
End Class
