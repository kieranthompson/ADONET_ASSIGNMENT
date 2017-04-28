Imports Oracle.DataAccess.Client

Public Class Form1

    Dim username As String
    Dim password As String
    Dim connectString As String

    Public con As New OracleConnection

    Public Function Connect() As OracleConnection
        Dim username As String = UserNameTxt.Text
        Dim password As String = PasswordTxt.Text
        Dim ConnectString As String = "Data Source=XE; user id=" & username & ";" & "Password=" & password & ";"
        Dim Con As New OracleConnection(ConnectString)
        Con.Open()
        MsgBox("Oracle DataBase Guitar Store is now open")
        Return Con

    End Function
    Private Sub LoginBtn_Click(sender As Object, e As EventArgs) Handles LoginBtn.Click
        Connect()
    End Sub
End Class
