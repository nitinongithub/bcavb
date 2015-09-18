VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4290
   ClientLeft      =   7830
   ClientTop       =   3720
   ClientWidth     =   4065
   LinkTopic       =   "Form1"
   ScaleHeight     =   4290
   ScaleWidth      =   4065
   Begin VB.ListBox lstName 
      Height          =   2205
      Left            =   360
      TabIndex        =   2
      Top             =   1680
      Width           =   3375
   End
   Begin VB.CommandButton cmdSubmit 
      Caption         =   "Submit"
      Height          =   375
      Left            =   2040
      TabIndex        =   1
      Top             =   960
      Width           =   1695
   End
   Begin VB.TextBox txtName 
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   360
      Width           =   3375
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim con As Connection
Dim rs As Recordset


Private Sub cmdSubmit_Click()
    Set con = New Connection
    Set rs = New Recordset
    
    con.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=sample.mdb;Persist Security Info=False"
    rs.Open "select * from student", con, adOpenStatic, adLockOptimistic
    
    rs.AddNew
        rs.Fields("name_") = txtName.Text
    rs.Update
    
    'Call the function to fill the listbox
    fillList
    '-------------------------------------
End Sub


Private Function fillList()
    Set con = New Connection
    Set rs = New Recordset
    
    con.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=sample.mdb; Persist Security Info=False"
    rs.Open "select * from student", con, adOpenStatic, adLockOptimistic
    
    lstName.Clear
    
    While Not rs.EOF
        lstName.AddItem (rs.Fields("name_"))
    rs.MoveNext
    Wend
End Function


Private Sub Form_Load()
    fillList
    txtName.Text = ""
End Sub
