# Splint_8051base
step 1. 將Splint_Read_Uv2.bat copy到splint同一個路徑下  
step 2. click start Splint_Read_Uv2.bat，會自動讀取Keil C的.Uv2 file讀取compiler的file檔，自動將需比對的.C，Inc資料夾下的.h檔路徑寫入到splint_8051.rc內  
step 3. 自動將splint可忽略判斷的定義寫入到splint_8051.rc內  
step 4. 自動執行splint_CMD.bat輸出splint output file
