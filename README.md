# LuckDraw
## 此project為一抽獎網頁程式，其提供建立抽獎活動、查看抽獎活動與查看抽獎記錄功能。  

**project功能需求:**  
- [x]  1. 架構需有前端網頁，後端商業邏輯處理程式，以及儲存結果的資料庫 
- [x]  2. 符合抽獎人數為60,000人
- [x]  3. 依序抽出獎項(每次點擊按鈕)  
- [x]  4. 每次抽獎時間不得超過2秒，抽過不得再抽，每個人抽到的機率需要相同(確保所抽的每一個都是有random過的)**- [x]  
- [x]  5. 可查詢已抽過之獎項人員名單  
      
**加分條件:**  
- [x]  1. 可重複使用，建立每次抽獎活動，輸入人員名單，多少獎項，已及其對應人數等
- [x]  2. 可查詢歷史抽獎活動已及對應抽獎之名單
- [ ]  3. 採用docker當作runtime 
    
 - [x] 為完成項目   
   
## 以下就資料庫、網頁設計與功能進行說明:  
  
**資料庫**  
    `員工資料庫從檔案 worker.csv匯入(共60000人)`  
    `已建立的資料表已匯出檔案 Dump20220523.sql`  
    `資料庫使用MySQL WORKBENCH 帳號密碼為root 1234 資料庫名稱為test`  
      
  **資料表共4個:**
  1. activity:儲存抽獎活動資訊，其欄位有id(系統自動產生)、aid(活動編號，型態為A+4碼數字如:A0001)、prizetype(獎項1~10獎)、num(該活動獎項的抽獎名額)、finished(該活動個獎是否抽完)、date(系統自動產生的時間戳，紀錄活動建立時間)
  2. history:儲存抽獎紀錄，其欄位有hid(系統自動產生)、aid(活動編號)、wid(員工代號)、prize(獎項)、timestamp(系統自動產生的時間戳，紀錄該人員被抽出的時間)    
  3. whitelist:儲存白名單(於建立活動時設定白名單人員，如未設定則默認全員皆可參與該抽獎活動)，其欄位有id(系統自動產生)、aid(活動編號)、wid(員工代號)  
  4. worker:員工名單(由worker.csv產生)，其欄位有id(員工代號，型態為W+6碼數字如:W000001)、name(員工名子)、certifi(設計為權限，未使用)  
      
 資料表關聯如下圖:  
 ![image](https://github.com/andy970139/LuckyDraw/blob/main/readme/er.png)  
 **網頁架構與設計**
 網頁樹狀結構圖如下:  
 ![image](https://github.com/andy970139/LuckyDraw/blob/main/readme/web_structure.png)  
 
 
