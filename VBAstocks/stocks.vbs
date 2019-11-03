Attribute VB_Name = "Module1"

Sub stocks()
    Dim CurrentWs As Worksheet
    Dim Start_Header As Boolean
    Dim Example_Sheet As Boolean
    
    Start_Header = False
    Example_Sheet = True

    For Each CurrentWs In Worksheets
        Dim Ticker_Symbol As String
        Ticker_Symbol = " "
        Dim Total_Ticker_Volume As Double
        Total_Ticker_Volume = 0
        Dim Min_Ticker_Symbol As String
        Min_Ticker_Symbol = " "
        Dim Max_Ticker_Symbol As String
        Max_Ticker_Symbol = " "
        Dim Min_Percent As Double
        Min_Percent = 0
        Dim Max_Percent As Double
        Max_Percent = 0
        Dim Max_Volume_Ticker As String
        Max_Volume_Ticker = " "
        Dim Max_Volume As Double
        Max_Volume = 0
        Dim Open_Price As Double
        Open_Price = 0
        Dim Close_Price As Double
        Close_Price = 0
        Dim Price_Change As Double
        Price_Change = 0
        Dim Percent_Change As Double
        Percent_Change = 0
        Dim Summary_Row As Long
        Summary_Row = 2
        Dim Last_Row As Long
        Dim i As Long
        
        Last_Row = CurrentWs.Cells(Rows.Count, 1).End(xlUp).Row
        
        If Start_Header Then
            CurrentWs.Range("I1").Value = "Ticker"
            CurrentWs.Range("J1").Value = "Yearly Change"
            CurrentWs.Range("K1").Value = "Percent Change"
            CurrentWs.Range("L1").Value = "Total Stock Volume"
            CurrentWs.Range("O2").Value = "Greatest % Increase"
            CurrentWs.Range("O3").Value = "Greatest % Decrease"
            CurrentWs.Range("O4").Value = "Greatest Total Volume"
            CurrentWs.Range("P1").Value = "Ticker"
            CurrentWs.Range("Q1").Value = "Value"
        Else
            Start_Header = True
        End If

        Open_Price = CurrentWs.Cells(2, 3).Value
        
        For i = 2 To Last_Row
            If CurrentWs.Cells(i + 1, 1).Value <> CurrentWs.Cells(i, 1).Value Then
                Ticker_Symbol = CurrentWs.Cells(i, 1).Value
                Close_Price = CurrentWs.Cells(i, 6).Value
                Price_Change = Close_Price - Open_Price
                If Open_Price <> 0 Then
                    Percent_Change = (Price_Change / Open_Price) * 100
                Else
                    MsgBox ("Something bombed.  Not sure.  Program should still run.")
                End If
                
                Total_Ticker_Volume = Total_Ticker_Volume + CurrentWs.Cells(i, 7).Value
                CurrentWs.Range("I" & Summary_Row).Value = Ticker_Symbol
                CurrentWs.Range("J" & Summary_Row).Value = Price_Change
                If (Price_Change > 0) Then
                    CurrentWs.Range("J" & Summary_Row).Interior.ColorIndex = 4
                ElseIf (Price_Change <= 0) Then
                    CurrentWs.Range("J" & Summary_Row).Interior.ColorIndex = 3
                End If
    
                CurrentWs.Range("K" & Summary_Row).Value = (CStr(Percent_Change) & "%")
                CurrentWs.Range("L" & Summary_Row).Value = Total_Ticker_Volume
                Summary_Row = Summary_Row + 1
                Price_Change = 0
                Close_Price = 0
                Open_Price = CurrentWs.Cells(i + 1, 3).Value
              
                If (Percent_Change > Max_Percent) Then
                    Max_Ticker_Symbol = Ticker_Symbol
                    Max_Percent = Percent_Change
                    
                ElseIf (Percent_Change < Min_Percent) Then
                    Min_Ticker_Symbol = Ticker_Symbol
                    Min_Percent = Percent_Change
                    
                End If
                       
                If (Total_Ticker_Volume > Max_Volume) Then
                    Max_Volume_Ticker = Ticker_Symbol
                    Max_Volume = Total_Ticker_Volume
                End If
                
                Percent_Change = 0
                Total_Ticker_Volume = 0
            Else
                Total_Ticker_Volume = Total_Ticker_Volume + CurrentWs.Cells(i, 7).Value
            End If
      
        Next i
        
            If Not Example_Sheet Then
                CurrentWs.Range("Q2").Value = (CStr(Max_Percent) & "%")
                CurrentWs.Range("Q3").Value = (CStr(Min_Percent) & "%")
                CurrentWs.Range("P2").Value = Max_Ticker_Symbol
                CurrentWs.Range("P3").Value = Min_Ticker_Symbol
                CurrentWs.Range("Q4").Value = Max_Volume
                CurrentWs.Range("P4").Value = Max_Volume_Ticker
                
            Else
                Example_Sheet = False
            End If
        
     Next CurrentWs
End Sub
