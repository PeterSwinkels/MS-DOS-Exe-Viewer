<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class CreateLayoutItemWindow
   Inherits System.Windows.Forms.Form

   'Form overrides dispose to clean up the component list.
   <System.Diagnostics.DebuggerNonUserCode()> _
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
   <System.Diagnostics.DebuggerStepThrough()> _
   Private Sub InitializeComponent()
        Me.AssemblyBox = New System.Windows.Forms.TextBox()
        Me.SuspendLayout()
        '
        'AssemblyBox
        '
        Me.AssemblyBox.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.AssemblyBox.BackColor = System.Drawing.SystemColors.Window
        Me.AssemblyBox.Font = New System.Drawing.Font("Consolas", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.AssemblyBox.Location = New System.Drawing.Point(-1, 1)
        Me.AssemblyBox.Multiline = True
        Me.AssemblyBox.Name = "AssemblyBox"
        Me.AssemblyBox.ReadOnly = True
        Me.AssemblyBox.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.AssemblyBox.Size = New System.Drawing.Size(804, 448)
        Me.AssemblyBox.TabIndex = 0
        '
        'CreateLayoutItemWindow
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(800, 450)
        Me.Controls.Add(Me.AssemblyBox)
        Me.KeyPreview = True
        Me.Name = "CreateLayoutItemWindow"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Create Layout Item"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents AssemblyBox As System.Windows.Forms.TextBox
End Class
