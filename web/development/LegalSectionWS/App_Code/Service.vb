Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Runtime.InteropServices


<WebService(Namespace:="http://tempuri.org/", Name:="LegalSection")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class Service
    Inherits System.Web.Services.WebService
    <WebMethod()> _
    Public Function SectionTownshipRangeByLatLong(ByVal Latitude As Single, ByVal Longitude As Single) As String
        Dim myLS As New LS.LegalSection
        Return myLS.LegalSectionFromLatLong(Math.Abs(Latitude), Math.Abs(Longitude))
    End Function
    <WebMethod()> _
    Public Function MeridianByLatLong(ByVal Latitude As Single, ByVal Longitude As Single)
        Dim myLS As New LS.LegalSection
        Return myLS.MeridianFromLatLong(Latitude, Longitude)
    End Function
    <WebMethod()> _
    Public Function StateByLatLong(ByVal Latitude As Single, ByVal Longitude As Single)
        Dim myLS As New LS.LegalSection
        Return myLS.StateFromLatLong(Latitude, Longitude)
    End Function
    <WebMethod()> _
    Public Function TownshipFromLatLong(ByVal Latitude As Single, ByVal longitude As Single)
        Dim myLS As New LS.LegalSection
        Dim myTRS As TRS

        Dim tmp As String
        tmp = myLS.LegalSectionFromLatLong(Math.Abs(Latitude), Math.Abs(longitude))
        myTRS = New TRS(tmp)

        Return myTRS.Township

    End Function
    <WebMethod()> _
        Public Function RangeFromLatLong(ByVal Latitude As Single, ByVal longitude As Single)
        Dim myLS As New LS.LegalSection
        Dim myTRS As TRS

        Dim tmp As String
        tmp = myLS.LegalSectionFromLatLong(Math.Abs(Latitude), Math.Abs(longitude))
        myTRS = New TRS(tmp)

        Return myTRS.Range

    End Function
    <WebMethod()> _
    Public Function SectionFromLatLong(ByVal Latitude As Single, ByVal longitude As Single)
        Dim myLS As New LS.LegalSection
        Dim myTRS As TRS

        Dim tmp As String
        tmp = myLS.LegalSectionFromLatLong(Math.Abs(Latitude), Math.Abs(longitude))
        myTRS = New TRS(tmp)

        Return myTRS.Section
    End Function
End Class
Public Class TRS
    Private m_Section As String
    Private m_Township As String
    Private m_Range As String
    Public ReadOnly Property Section() As String
        Get
            Return Me.m_Section
        End Get
    End Property
    Public ReadOnly Property Township() As String
        Get
            Return Me.m_Township
        End Get
    End Property
    Public ReadOnly Property Range() As String
        Get
            Return Me.m_Range
        End Get
    End Property
    Public Sub New(ByVal TRSString As String)
        Dim TEnd As Long
        Dim RStart As Long
        Dim REnd As Long
        Dim SStart As Long
        
        If InStr(TRSString, "S") <> 0 Then
            TEnd = InStr(TRSString, "S")
            Me.m_Township = "T" & Left(TRSString, TEnd)
        Else
            TEnd = InStr(TRSString, "N")
            Me.m_Township = "T" & Left(TRSString, TEnd)
        End If
        RStart = TEnd + 1                   'range starts at township end + 1

        
        If InStr(TRSString, "E") <> 0 Then
            REnd = InStr(TRSString, "E")
            Me.m_Range = Mid(TRSString, RStart, (REnd - RStart) + 1)
        Else
            REnd = InStr(TRSString, "W")
            Me.m_Range = Mid(TRSString, RStart, (REnd - RStart) + 1)
        End If

        SStart = REnd + 1

        Me.m_Section = Mid(TRSString, SStart)


    End Sub
End Class
