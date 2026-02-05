Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI
定案新版 v1.4.0
[ANCHOR:SPLMVP-RB-V140-COVER]
________________


封面卡（Doc Meta）
[ANCHOR:SPLMVP-DOC-META]
欄位
        值
        doc_id
        Spartoi_SubP1-LITE-MVP_DevRunbook_WI_v1.4.0
        version
        v1.4.0
        status
        RELEASE
        release_date
        2026-01-18 (Asia/Taipei)
        supersedes
        Spartoi_SubP1-LITE-MVP_DevRunbook_WI_v1.3.0, Spartoi_SubP1-LITE-MVP_DevRunbook_WI_v1.1.0, Spartoi_SubP1-LITE-MVP_DevRunbook_WI_v1.0.0
        author
        AI Integrator (Claude) + Human Review
        review_status
        AUDIT_INTEGRATED
        版本號判定理由：
1. 新增四大高槓桿Skills執行指引（§6.3.8.2）
2. 新增CR_OPEN狀態對齊表（§10）
3. 新增Solo-Mode HITL操作規範（§6.8.7）
4. 新增Web Evidence Index引用（附錄M）
5. 新增Verified Status處置SOP（附錄N）
故版本號由v1.3.0升級為v1.4.0。


________________


Supersedes Declaration（取代宣告）
[ANCHOR:SPLMVP-SUPERSEDES]
本文件完全取代以下版本，使用者不必再翻閱舊版：
被取代版本
	doc_id
	取代原因
	v1.1.0
	Spartoi_SubP1-LITE-MVP_DevRunbook_WI_v1.1.0
	本版整合審查報告修補、降級為Implementation SSOT
	v1.0.0
	Spartoi_SubP1-LITE-MVP_DevRunbook_WI_v1.0.0
	v1.1.0已取代v1.0.0，本版再取代v1.1.0
	________________


修補完成宣告（Patch Completion Declaration）
[ANCHOR:SPLMVP-PATCH-DECLARATION-V140]
本版 v1.4.0 已完成以下硬性條款：
條款
	狀態
	驗證點
	雙憲法降級：Authority Stack改為引用藍圖
	✅ DONE
	§2.1 引用 BP-AUTHORITY-STACK
	One-rule-one-place 落地
	✅ DONE
	附錄E Placement Table
	DRIFT-001 Authority Stack不一致
	✅ FIXED
	§2.1
	DRIFT-002 evidence_ptr路徑範例不足
	✅ FIXED
	附錄H
	DRIFT-003 WI卡縮減無ADR
	✅ FIXED
	§5.5 ADR-RB-001
	ORP-001 One-rule-one-place違反
	✅ FIXED
	§2.1 + 附錄E
	分離「開發過程」vs「實際使用」工具規劃
	✅ DONE
	§6.3 vs §6.4
	WP 單檔制模板到位
	✅ DONE
	§5.2
	GateKit 工程層 /gates/ 目錄結構
	✅ DONE
	§7.5
	15 子系統 stopline 欄位補齊
	✅ DONE
	§8.2
	Coverage Matrix 完整
	✅ DONE
	附錄D
	Crosswalk 完整 + evidence_ptr範例
	✅ DONE
	附錄H
	CR_OPEN 登記
	✅ DONE
	§10 + 附錄I
	DoD（Definition of Done）：本文件可100%取代v1.1.0與v1.0.0，使用時不必再翻舊版。
________________


完整目錄（TOC）
[ANCHOR:SPLMVP-TOC-V140]
章節
	名稱
	錨點
	本節DoD
	§0
	Preflight
	SPLMVP-S0-PREFLIGHT
	全部輸入檢索完成、Authority Stack確認
	§1
	Charter憲章
	SPLMVP-S1-CHARTER
	文檔定位為Implementation SSOT
	§2
	Authority Stack + Scope-Lock
	SPLMVP-S2-AUTHORITY
	引用藍圖SSOT、衝突裁決規則明確
	§3
	全局流程總覽
	SPLMVP-S3-OVERVIEW
	端到端閉環圖、開發階段順序釘死
	§4
	Stage級RUNBOOK
	SPLMVP-S4-RUNBOOK
	每Stage有Outcome/Steps/Verify/Rollback/Evidence
	§5
	WI操作卡 + WP單檔制
	SPLMVP-S5-WI-CARDS
	固定schema、WP模板、WI卡ADR
	§6
	Pipeline與Agent協作規範
	SPLMVP-S6-PIPELINE
	開發過程/實際使用分離、Agent骨架明確
	§7
	Gate與EvidencePack規範
	SPLMVP-S7-GATE
	8Gate模板齊全、GateKit結構明確
	§8
	15子系統MVP最小行為
	SPLMVP-S8-SUBSYS
	每子系統verify_min/stopline明確
	§9
	Failure Modes
	SPLMVP-S9-RISK
	Top10風險與最小防線
	§10
	CR_OPEN Register
	SPLMVP-S10-CR-OPEN
	Candidate→CR_OPEN遷移規則明確
	附錄A
	8 Gate模板詳細規格
	SPLMVP-APPX-A
	每Gate含judgment_logic/evidence_schema
	附錄B
	WI操作卡集
	SPLMVP-APPX-B
	關鍵WI卡完整
	附錄C
	Manifest/Schema/Checklists
	SPLMVP-APPX-C
	EvidencePack/Manifest骨架
	附錄D
	Coverage Matrix
	SPLMVP-APPX-D
	需求A/B/討論版/藍圖覆蓋矩陣
	附錄E
	One-rule-one-place Placement Table
	SPLMVP-APPX-E-PLACEMENT
	防雙憲法檢查表
	附錄F
	Changelog
	SPLMVP-APPX-F
	版本變更記錄
	附錄G
	術語表
	SPLMVP-APPX-G
	核心術語定義
	附錄H
	Crosswalk映射表
	SPLMVP-APPX-H
	台股流程母本對照+evidence_ptr範例
	附錄I
	CR_OPEN詳細清單
	SPLMVP-APPX-I
	待決事項登記
	附錄J
	Issue Closure Table
	SPLMVP-APPX-J
	審查報告逐條結案
	附錄K
	Anti-Regression Preservation Map
	SPLMVP-APPX-K
	舊版→新版對照
	附錄L
	Blueprint Patch Plan
	SPLMVP-APPX-L
	需回填藍圖的補丁
	________________


全文錨點策略（Anchor Scheme）
[ANCHOR:SPLMVP-ANCHOR-SCHEME]
本文件採用以下錨點命名規則：
層級
	格式
	範例
	章節
	SPLMVP-S{n}-{NAME}
	SPLMVP-S1-CHARTER
	附錄
	SPLMVP-APPX-{X}
	SPLMVP-APPX-A
	子段
	SPLMVP-{TOPIC}-{SUBTOPIC}
	SPLMVP-WP-TEMPLATE
	藍圖引用
	BP-{ANCHOR}
	BP-AUTHORITY-STACK
	引用格式：見 [BP-AUTHORITY-STACK] 表示引用藍圖SSOT的錨點。
________________


Quick Index（關鍵詞→錨點快速索引）
[ANCHOR:SPLMVP-QUICK-INDEX-V140]
關鍵詞
	錨點
	章節
	Authority Stack
	SPLMVP-AUTHORITY-REF
	§2.1
	藍圖引用
	BP-AUTHORITY-STACK
	藍圖SSOT §0.2
	Runbook
	SPLMVP-S4-RUNBOOK
	§4
	WI操作卡
	SPLMVP-S5-WI-CARDS
	§5
	WP單檔制
	SPLMVP-WP-TEMPLATE
	§5.2
	Front-Matter
	SPLMVP-FRONT-MATTER
	§5.2.3
	T0/T1路由
	SPLMVP-T0T1-ROUTE
	§5.2.4
	GateKit
	SPLMVP-S7-GATE
	§7
	GateKit工程層
	SPLMVP-GATEKIT-ENG
	§7.5
	Agent開發過程
	SPLMVP-AGENT-DEV
	§6.3
	Agent實際使用
	SPLMVP-AGENT-OPS
	§6.4
	Agent切換
	SPLMVP-AGENT-TOGGLE
	§6.5
	Codespaces
	SPLMVP-CODESPACES
	§6.3.2
	Codex
	SPLMVP-CODEX
	§6.3.2
	Claude Code
	SPLMVP-CLAUDE-CODE
	§6.3.3
	Pipeline A/B/C
	SPLMVP-PIPELINE-ABC
	§6.1
	SpecPack
	SPLMVP-SPECPACK
	§6.1.1
	StrategyPack
	SPLMVP-STRATEGYPACK
	§6.1.2
	XSPack
	SPLMVP-XSPACK
	§6.1.3
	MVP Spine
	SPLMVP-MVP-SPINE
	§3
	Mini Core Four
	SPLMVP-MINI-CORE-FOUR
	§5.3
	15子系統
	SPLMVP-S8-SUBSYS
	§8
	XQ唯一下單端
	SPLMVP-XQ-SOLE
	§1.4
	Route-Out
	SPLMVP-ROUTE-OUT
	§2.3
	CR_OPEN
	SPLMVP-S10-CR-OPEN
	§10
	Fail-Closed
	SPLMVP-FAIL-CLOSED
	§2.2
	stopline
	SPLMVP-STOPLINE
	§8
	Gate模板
	SPLMVP-APPX-A
	附錄A
	WI卡ADR
	SPLMVP-ADR-WI
	§5.5
	Coverage Matrix
	SPLMVP-APPX-D
	附錄D
	Issue Closure
	SPLMVP-APPX-J
	附錄J
	One-rule-one-place
	SPLMVP-APPX-E-PLACEMENT
	附錄E
	________________


AI Reader Guide（AI讀取指南）
[ANCHOR:SPLMVP-AI-READER-GUIDE]
強制檢索路徑
1. 先讀 §1 Charter + §2 Authority Stack：理解本RUNBOOK為「Implementation SSOT」，規劃層權威在藍圖SSOT
2. 再讀 §3 全局流程總覽：掌握開發階段順序（Phase 0-5不可變更）
3. 引用任何規範時：必須附 evidence_ptr（來源文件 + 錨點定位）
4. 遇到缺口：查 §10 CR_OPEN Register，禁止臆測補洞
5. 遇到規劃層問題：查藍圖SSOT [BP-*]錨點，本RUNBOOK不得自行定義
Docs-as-Code × Diátaxis 段落分層
[ANCHOR:SPLMVP-DIATAXIS]
類型
	定位
	本文件落點
	Tutorial
	學習導向、循序步驟
	§4 Stage級RUNBOOK
	How-to
	問題導向、具體任務
	§5 WI操作卡
	Reference
	資訊導向、精確查找
	附錄A-L
	Explanation
	理解導向、背景脈絡
	§1 Charter（最小化）
	分層規則：Tutorial/How-to不得混寫；Reference純查表不說教；Explanation僅限Charter必要背景。
GraphRAG/RAPTOR/CRAG 檢索友善設計
[ANCHOR:SPLMVP-RAG-FRIENDLY]
設計項目
	落點
	說明
	錨點索引
	Quick Index
	關鍵詞→錨點快速定位
	層級標籤
	每章節標題
	[ANCHOR:xxx] 可被檢索器解析
	證據路徑
	evidence_ptr欄位
	每步驟指向證據落盤位置
	引用鏈
	來源標註
	[SRC:xxx] 可追溯上游SSOT
	RAG-Triad 指標最小化落點
[ANCHOR:SPLMVP-RAG-TRIAD]
RAG指標
	本文件實現
	Faithfulness（忠實度）
	每條規範必附 evidence_ptr 或藍圖引用
	Answer Relevance（答案相關性）
	Quick Index + 錨點策略確保精準檢索
	Context Relevance（上下文相關性）
	每步驟定義 Preconditions/Inputs 前置脈絡
	防幻覺硬規則
[ANCHOR:SPLMVP-ANTI-HALLUCINATION]
規則
	說明
	No-Source-No-Norm
	無 evidence_ptr/藍圖引用 的規範句不得生效
	Fail-Closed
	缺口/衝突 → BLOCK_RELEASE，不得假設通過
	禁止數值門檻於Normative
	數值門檻只能在 CR_OPEN/Evidence_Refs
	不得自創術語
	Gate/Flag/Policy名稱必須與上游SSOT一致
	15子系統白名單固定
	不得新增第16個子系統
	8 Gate模板固定
	不得新增第9個模板
	XQ唯一下單端
	所有下單必經XQ，本地系統僅產生訊號/指令
	One-rule-one-place
	規則只能存在藍圖或RUNBOOK其一，另一方只能引用
	________________


免責與安全邊界聲明
[ANCHOR:SPLMVP-DISCLAIMER]
⚠️ 本文件聲明
1. 非投資建議：本文件僅為流程規格描述，不構成任何投資建議、推薦或招攬
2. 風險自負：任何依據本流程進行之交易行為，風險由操作者自行承擔
3. XQ唯一下單端：本地系統僅產生指令文件、訊號、證跡與紀錄；實際下單與成交僅在「XQ全球贏家」端完成
4. 不可替代專業意見：交易決策應諮詢合格之金融專業人士
5. 技術方法僅供佔位：文中提及之ICT模組名稱僅作為「基礎方法（ICT 1~107 模組）欄位佔位」，不作教學或發明新規範
6. HITL停止線：所有涉及資金操作之步驟必須經人工確認（Human-In-The-Loop），禁止unattended自動下單
7. Fail-Closed預設行為：遇不確定情況預設阻斷，不得假設通過
________________


§0 Preflight
[ANCHOR:SPLMVP-S0-PREFLIGHT]
本節DoD：全部輸入文件已檢索FOUND、Authority Stack已確認、無MISSING項目
§0.1 Inputs Manifest
[ANCHOR:SPLMVP-INPUTS-MANIFEST]
序號
	文件名
	版本
	用途
	狀態
	1
	藍圖SSOT
	v1.2.1
	規劃憲法/裁決層SSOT
	✅ FOUND
	2
	審查報告 v1.0.0
	v1.0.0
	修補指令SSOT
	✅ FOUND
	3
	RUNBOOK & WI v1.1.0
	v1.1.0
	被修補基底
	✅ FOUND
	4
	RUNBOOK & WI v1.0.0
	v1.0.0
	前版參考
	✅ FOUND
	5
	需求總表A
	v1.0.0
	100%覆蓋核對（34條）
	✅ FOUND
	6
	需求總表B
	v1.0.0
	100%覆蓋核對（25條+50條）
	✅ FOUND
	7
	討論整合版
	v1.0.0
	討論入口SSOT
	✅ FOUND
	8
	討論紀錄-A
	-
	原則/定位/邊界
	✅ FOUND
	9
	討論紀錄-B（單人作坊精品V2）
	-
	最終裁定SSOT
	✅ FOUND
	10
	討論紀錄-C（AGENT）
	-
	Agent開發/3 Pipeline
	✅ FOUND
	11
	台股當沖隔日沖 RUNBOOK&WI
	v2.0.0
	操作層SSOT
	✅ FOUND
	12
	台股當沖隔日沖實際流程
	v1.0.0 Final
	實際流程SSOT
	✅ FOUND
	13
	各階段子系統操作流程
	v1.0.1
	子系統操作SSOT
	✅ FOUND
	14
	P2/P2.5 WP單檔三合一
	-
	WP規格母本
	✅ FOUND
	15
	P0-Q&A_1114
	-
	P0核心需求
	✅ FOUND
	16
	Spartoi系統21項需求
	-
	21項系統硬需求
	✅ FOUND
	17
	P1_SRS v7.0.0
	v7.0.0
	需求契約SSOT
	✅ FOUND
	18
	P1_ARCH v6.0.0-r5
	v6.0.0-r5
	架構設計SSOT
	✅ FOUND
	Fail-Closed結論：18/18 FOUND，無MISSING項目。
________________


§1 Charter（憲章）
[ANCHOR:SPLMVP-S1-CHARTER]
本節DoD：文檔定位為Implementation SSOT、禁止事項、核心術語已明確定義
§1.1 文檔定位（Implementation SSOT）
[ANCHOR:SPLMVP-DOC-POSITIONING]
本《SubP1-LITE + MVP 開發 RUNBOOK & WI》為交付導向的操作手冊（Implementation SSOT），其任務是：
1. 把SubP1-LITE + MVP + Agent的交付活動，拆成可重複執行的步驟
2. 把每一步的輸入/輸出/驗證/回滾寫成可稽核格式
3. 讓「單人 + 多AI/LLM協作」能像"多人協作"一樣可交接、可追蹤、可回放
來源：[SRC:討論B｜§5｜"《SubP1-LITE+MVP_RUNBOOK/WI》這份文件的定位與職責"]
雙SSOT分工（防雙憲法）
[ANCHOR:SPLMVP-DUAL-SSOT]
SSOT類型
	文件
	職責
	規劃憲法/裁決層SSOT
	藍圖SSOT v1.2.1
	Authority Stack、Conflict Rule、Scope-Lock、Gate policy/Stopline定義、One-rule-one-place規則歸屬
	Implementation SSOT
	本RUNBOOK v1.4.0
	Step-by-step流程、每步I/O/驗證/回滾/證據落點、handoff/manifest、操作層治理
	硬規則：本RUNBOOK不得自行"重新定義"藍圖已定義的規則；只能引用藍圖SSOT的錨點（anchor）與版本。
§1.2 讀者對象
[ANCHOR:SPLMVP-AUDIENCE]
讀者類型
	使用場景
	負責產出SubP1-LITE+MVP+Agent的AI/開發者
	開發過程（§6.3）
	需要理解G5 GateKit工程規約的開發者
	§7 Gate規範
	需要執行3 Pipeline協作流程的團隊成員
	§6.1 Pipeline A/B/C
	需要執行日常交易流程的使用者
	實際使用（§6.4）
	工具規劃分章原則：
* 開發過程+實作 → §6.3
* 開發後的實際使用 → §6.4
* 兩者禁止混寫同段
§1.3 核心術語定義
[ANCHOR:SPLMVP-GLOSSARY-CORE]
術語
	定義
	來源
	SubP1-LITE
	P1內部工序，為子系統建立最小交付映射與局部收斂
	[SRC:討論A｜§1]
	MVP Spine
	最小可用閉環（MVR），不是最小文件集
	[SRC:討論A｜§3.1]
	Walking Skeleton
	端到端可跑通的最薄系統骨架
	[SRC:討論B｜§7]
	Mini Core Four
	每個子系統的四件核心文檔：SS_README/SS_SRS/SS_ARCH/SS_DELIVER
	[SRC:討論B｜§8]
	HITL
	Human-In-The-Loop，人機介入點
	[SRC:整合版｜§6]
	GateKit
	G5共享Gate模板+執行器+報告格式
	[SRC:討論B｜§1]
	SpecPack
	Pipeline A產出：偽代碼/原語/DSL規格包
	[SRC:討論C｜§41]
	StrategyPack
	Pipeline B-Strategy產出：方法卡/回測報告包
	[SRC:討論C｜§41]
	XSPack
	Pipeline C產出：XS腳本/選股/故事卡包
	[SRC:討論C｜§41]
	Fail-Closed
	缺輸入/缺證據/缺驗證→視為未完成，阻斷下游
	[SRC:整合版｜§0.4]
	EvidencePack
	每次pipeline產出的三件套（manifest/gate_report/run_log）
	[SRC:需求A｜§33]
	§1.4 XQ唯一下單端（高強度防誤解）
[ANCHOR:SPLMVP-XQ-SOLE]
引用藍圖：見 [BP-XQ-SOLE-ENDPOINT]
硬規則
	說明
	XQ全球贏家桌面軟體 = 唯一下單端
	本地系統/雲端只產生訊號/指令文件/證據
	禁止偷換成「自動下單」
	所有資金操作必須HITL人工確認
	CA-WATCH不下單
	僅提醒、訊號、證跡、WatchScore
	§1.5 禁止事項（硬規則）
[ANCHOR:SPLMVP-PROHIBITIONS]
規則ID
	規則內容
	違反後果
	R-1
	禁止擴寫：不得新增SRS/ARCH未授權的新功能需求
	BLOCK_RELEASE
	R-2
	禁止百科化：除"完成此步驟所必需"外，不得加入教學性背景
	回退
	R-3
	步驟可驗證：每個Step必須附驗證方法
	Step無效
	R-4
	輸出物唯一化：每個Step必須指定唯一輸出物ID/路徑/格式
	Step無效
	R-5
	失敗可處置：每個會改狀態的Step必須寫rollback/stop
	Step無效
	R-6
	分層一致：Runbook只描述流程；WI才描述逐步操作
	重構
	R-7
	非範圍內容轉出：延伸討論只能Link/Ref，不得搬運
	刪除
	R-8
	15子系統白名單：不得發明第16個子系統
	BLOCK_RELEASE
	R-9
	XQ唯一下單端：本地只產指令文件/訊號，不得下單
	BLOCK_RELEASE
	R-10
	allow_xsat預設false：不可被子系統放寬
	BLOCK_RELEASE
	R-11
	One-rule-one-place：規則只能存在藍圖或RUNBOOK其一
	重構/刪除重複
	R-12
	禁止自定義Authority Stack：必須引用藍圖定義
	改為引用
	

§1.6 Tripwires引用
[ANCHOR:SPLMVP-TRIPWIRES-REF]


**引用藍圖**：[BP-TRIPWIRES-V121]


本Runbook適用的Tripwires：
- TW-001 ~ TW-007：見藍圖原有定義
- TW-008 ~ TW-012：Cowork/Skills相關（v1.2.1新增）
  - TW-008：Cowork平台化偵測
  - TW-009：Skills規範越界偵測
  - TW-010：操作細節回塞偵測
  - TW-011：UNVERIFIED偷渡偵測
  - TW-012：Web入規範偵測


規範細節：見藍圖 [BP-TRIPWIRES-V121]


________________


§2 Authority Stack + Scope-Lock
[ANCHOR:SPLMVP-S2-AUTHORITY]
本節DoD：Authority Stack為藍圖引用、衝突裁決規則明確、In/Out-of-Scope邊界明確
§2.1 Authority Stack（引用藍圖SSOT）
[ANCHOR:SPLMVP-AUTHORITY-REF]
⚠️ 雙憲法降級聲明：本RUNBOOK不自行定義Authority Stack，改為引用藍圖SSOT。
藍圖SSOT Authority Stack（規劃層，引用）
引用來源：見 [BP-AUTHORITY-STACK]（藍圖SSOT §0.2）
順位
	來源
	說明
	A0
	本指令內嵌Scope-Lock
	最高硬規則：In/Out-of-Scope、Tripwires
	A1
	P0-Q&A_1114
	核心閉環與日常任務a-m
	A2
	REQ21
	21項系統硬需求
	A3
	P1_SRS v7.0.0
	需求契約SSOT；門檻數值規則
	A4
	P1_ARCH v6.0.0-r5
	15子系統命名/邊界SSOT
	A5
	需求總表A/B
	本次藍圖逐條落地
	A6
	討論整合版v1.0.0
	交付規劃入口
	A7
	討論-B最終裁定
	G5/GateKit/GateRunner最終定案
	A8
	開發RUNBOOK&WI v1.4.0
	工程落地型態（Implementation SSOT）
	A9
	台股流程母本三份
	流程/產物/不變量映射
	本RUNBOOK增量（操作層）
[ANCHOR:SPLMVP-AUTHORITY-INCREMENT]
增量順位
	文件
	用途
	+A10
	審查報告 v1.0.0
	本次修補指令
	+A11
	P2/P2.5 WP單檔三合一
	WP規格母本
	衝突裁決規則
引用藍圖：見 [BP-AUTHORITY-STACK] 衝突裁決規則
1. 高順位覆蓋低順位
2. 同順位以最新版本為準
3. 若仍無法裁決 → 登記CR_OPEN + Fail-Closed
4. Legacy（ICT教材）不得升格成Normative
§2.2 Fail-Closed原則
[ANCHOR:SPLMVP-FAIL-CLOSED]
引用藍圖：見 [BP-FAIL-CLOSED]
情境
	行為
	遇不確定
	預設阻斷，不得假設通過
	Gate失敗
	BLOCK_RELEASE
	缺口/衝突
	BLOCK_RELEASE
	數值門檻未授權
	CR_OPEN + 只記錄不判定
	交接失敗
	BLOCK下游Pipeline
	引用錨點不存在
	標記BLOCKED + 登記CR_OPEN
	Gate Policy 三態定義
來源：[SRC:SRS v7.0.0｜§0.4]
Policy
	行為
	適用場景
	BLOCK_RELEASE
	阻斷發布，不得進入下游
	關鍵安全/合規Gate
	RADAR_ONLY
	記錄但不阻斷，允許繼續但標記風險
	非關鍵品質Gate
	EXECUTE_DISABLED
	禁止執行但可研究/回測
	實驗性功能Gate
	§2.3 Scope-Lock
[ANCHOR:SPLMVP-SCOPE-LOCK]
引用藍圖：見 [BP-SCOPE-LOCK]
In-Scope（本文件允許寫）
項目
	規範要求
	本文落點
	Repo/資料夾結構
	命名規則、版本規則
	§4-§5
	任務流程
	資料→語料→蒸餾→DSL→SpecPack→實作→驗證→回饋
	§3-§4
	Multi-agent協作交接
	manifest、handoff、審查、合併
	§6
	Gate/檢查點
	何時算過、需要哪些證據（操作層）
	§7
	15子系統MVP最小行為
	最小可行行為（verify_min/stopline）
	§8
	Agent提速骨架
	AGENTS.md/CLAUDE.md/commands
	§6
	WI操作卡
	逐步操作指令
	§5
	Out-of-Scope（禁止寫 / Route-Out）
[ANCHOR:SPLMVP-ROUTE-OUT]
項目
	Route-Out目標
	Authority Stack定義
	→ 藍圖SSOT [BP-AUTHORITY-STACK]
	Conflict Rule定義
	→ 藍圖SSOT [BP-AUTHORITY-STACK]
	Gate分類/模板定義（7類+8模板）
	→ 藍圖SSOT [BP-7-GATE-CLASSES] [BP-8-GATE-TEMPLATES]
	Tripwires定義
	→ 藍圖SSOT [BP-TRIPWIRES]
	交易策略細節教學、盤感、技術分析大全
	→ MethodCard
	完整架構設計推導
	→ ARCH/ADR
	全量需求條文
	→ SRS
	工具源碼逐行解釋
	→ Code Doc
	大量"可選做法"清單
	→ CR_OPEN
	數值門檻硬規範
	→ CR_OPEN/Evidence_Refs
	

§2.5 No-API主路徑裁決引用
[ANCHOR:SPLMVP-NO-API-RULING]


**引用藍圖**：[BP-NO-API-RULING]


本Runbook遵循藍圖No-API主路徑裁決：
- 主路徑：No-API模式（純GateRunner + HITL）
- API例外：需經CR_OPEN-022審批
- 規範細節：見藍圖 [BP-NO-API-RULING]


________________


§3 全局流程總覽
[ANCHOR:SPLMVP-S3-OVERVIEW]
本節DoD：端到端閉環圖已繪製、開發階段順序已釘死（Phase 0-5不可變更）
§3.1 交付順序（不可變更）
[ANCHOR:SPLMVP-DELIVERY-ORDER]
引用藍圖：見 [BP-DELIVERY-ORDER]
Phase 0: Preflight
    ↓
Phase 1: XQ/XS v0 Connectivity Spike
    ↓
Phase 2: 15子系統 Mini Core Four
    ↓
Phase 3: 各子系統 WP（單檔三合一）
    ↓
Phase 4: GateKit + Regression Suite
    ↓
Phase 5: MVP Spine v1 收束


§3.2 端到端閉環主幹
[ANCHOR:SPLMVP-E2E-SPINE]
┌─────────────────────────────────────────────────────────────────────────┐
│                    Spartoi MVP 最短閉環路徑圖                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  【輸入】ICT PDF/教材                                                    │
│      │                                                                  │
│      ▼                                                                  │
│  【CA-WRC】匯入 → input_manifest.json ─────┐                            │
│      │                                      │                           │
│      ▼                                      │                           │
│  【CA-CORPUS】索引 → corpus_snapshot.json   │ Pipeline A                 │
│      │                                      │ (SpecPack)                │
│      ▼                                      │                           │
│  【CA-DISTILL】蒸餾 → distill_bundle.json   │                           │
│      │                                      │                           │
│      ▼                                      │                           │
│  【CA-DSL】原語庫 → dsl_schema.json ────────┘                           │
│      │                                                                  │
│      ▼                                                                  │
│  【CA-METHOD】方法卡 → method_card.md ──────┐                           │
│      │                                      │                           │
│      ▼                                      │ Pipeline B                 │
│  【CA-BACKTEST】回測 → backtest_report.json │ (StrategyPack)            │
│      │                                      │                           │
│      └──────────────────────────────────────┘                           │
│                              │                                          │
│                              ▼                                          │
│  【CA-TA】技術分析 → ta_pack.json ──────────┐                           │
│      │                                      │                           │
│      ▼                                      │ Pipeline C                 │
│  【CA-SELECT】選股 → select_results.json    │ (XSPack)                  │
│      │                                      │                           │
│      ▼                                      │                           │
│  【CA-TRANSLATE】XS轉譯 → xs_pack.zip ──────┘                           │
│      │                                                                  │
│      ▼                                                                  │
│  【CA-WATCH】盯盤 → watch_plan.json                                     │
│      │                                                                  │
│      ▼ (HITL)                                                           │
│  【CA-EXECUTE】操盤 → hitl_handoff.json ────► 【XQ全球贏家】實際下單     │
│      │                                                                  │
│      ▼                                                                  │
│  【CA-PERFORM】績效 → perf_summary.json ────► 回饋至 CA-METHOD          │
│      │                                                                  │
│      ▼                                                                  │
│  【CA-GOVERN】治理 → gov_evidence_pack.zip                              │
│      │                                                                  │
│      ▼                                                                  │
│  【CA-COLLAB】協作 → export_bundle.zip                                  │
│      │                                                                  │
│      ▼                                                                  │
│  【CA-UI】入口 → E2E smoke通過 → MVP Spine v1 COMPLETE                  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘


§3.3 Phase交付欄位模板
[ANCHOR:SPLMVP-PHASE-TEMPLATE]
每個Phase必須使用以下固定欄位：
欄位
	說明
	Phase ID
	Phase-{0-5}
	名稱
	Phase名稱
	Outcome
	完成定義（DoD）
	Preconditions
	前置條件
	Inputs
	輸入物清單
	Steps
	執行步驟
	Outputs
	輸出物清單
	Verify
	驗證方法
	Rollback
	回滾/降級動作
	EvidencePack Path
	證據落盤路徑
	Stopline
	停止線條件
	Fail-Closed Behavior
	失敗阻斷行為
	Handoff Contract
	交接契約
	Gate綁定
	對應Gate ID
	§4 Stage級RUNBOOK
[ANCHOR:SPLMVP-S4-RUNBOOK]
本節DoD：每個Stage有Outcome/Steps/Verify/Rollback/Evidence
§4.1 Phase 0: Preflight
[ANCHOR:SPLMVP-PHASE-0]
欄位
	內容
	Phase ID
	Phase-0
	名稱
	Preflight
	Outcome
	Inputs Manifest完整、Authority Stack確認（引用藍圖）、Scope-Lock驗證
	Preconditions
	所有輸入文件可訪問
	Inputs
	藍圖SSOT、審查報告、需求總表A/B、討論版、台股母本
	Steps
	Step 0.1 建立Authority Stack引用表；Step 0.2 建立Scope-Lock配置；Step 0.3 驗證Inputs Manifest
	Outputs
	/evidence/preflight/preflight_manifest.json
	Verify
	18/18 FOUND、無MISSING
	Rollback
	缺關鍵輸入 → 列出缺失清單 → 阻斷
	EvidencePack Path
	/evidence/preflight/{run_id}/
	Stopline
	任一MISSING → STOP
	Fail-Closed Behavior
	缺關鍵輸入 → 阻斷全流程
	Handoff Contract
	preflight_manifest.json → Phase-1
	Gate綁定
	G-SRC
	Step 0.1 建立Authority Stack引用表
[ANCHOR:SPLMVP-STEP-0-1]
step_id: Step-0.1
step_name: 建立Authority Stack引用表
inputs:
  - 藍圖SSOT v1.2.1 [BP-AUTHORITY-STACK]
outputs:
  - /config/authority_stack_ref.yaml
verify:
  - authority_stack_ref.yaml存在
  - 引用藍圖錨點可解析
rollback:
  - 若藍圖錨點不存在 → 標記BLOCKED + 登記CR_OPEN
evidence_ptr: /evidence/preflight/{run_id}/authority_stack_ref.yaml


Step 0.2 建立Scope-Lock配置
[ANCHOR:SPLMVP-STEP-0-2]
step_id: Step-0.2
step_name: 建立Scope-Lock配置
inputs:
  - 藍圖SSOT v1.2.1 [BP-SCOPE-LOCK]
outputs:
  - /config/scope_lock.yaml
verify:
  - scope_lock.yaml存在
  - In-Scope/Out-of-Scope明確
rollback:
  - 若Scope衝突 → 以藍圖為準
evidence_ptr: /evidence/preflight/{run_id}/scope_lock.yaml


§4.2 Phase 1: XQ/XS v0 Connectivity Spike
[ANCHOR:SPLMVP-PHASE-1]
欄位
	內容
	Phase ID
	Phase-1
	名稱
	XQ/XS v0 Connectivity Spike
	Outcome
	XS編譯通過、XQ載入成功、signal parity驗證
	Preconditions
	Phase-0 完成
	Inputs
	XS語法草稿、XQ環境
	Steps
	Step 1.1 XS語法編譯；Step 1.2 XQ載入測試；Step 1.3 Signal parity驗證
	Outputs
	/evidence/connectivity/connectivity_report.json, xs_compile_log.txt
	Verify
	XS可編譯、XQ可載入、parity >= 95%
	Rollback
	編譯失敗 → 修正語法 → 重試
	EvidencePack Path
	/evidence/connectivity/{run_id}/
	Stopline
	連接性失敗 → STOP，禁止進入Phase-2
	Fail-Closed Behavior
	連接性失敗 → BLOCK Phase-2
	Handoff Contract
	connectivity_report.json → Phase-2
	Gate綁定
	G-XQ-PARITY
	規則：Mini Core Four之前必須先通過Connectivity Spike
WI-XQ-CONNECTIVITY-SPIKE-001
[ANCHOR:SPLMVP-WI-XQ-SPIKE]
wi_id: WI-XQ-CONNECTIVITY-SPIKE-001
wi_name: XQ/XS v0 連接性驗證
所屬Stage: Phase-1


inputs:
  - xs_draft.txt（最小XS語法草稿）
  - XQ環境（已安裝全球贏家）


steps:
  1. 開啟XQ全球贏家 → 進入XS編輯器
  2. 載入xs_draft.txt
  3. 點擊「編譯」按鈕
  4. 若編譯成功 → 記錄compile_log.txt
  5. 若編譯失敗 → 記錄錯誤訊息 → 修正 → 重試
  6. 編譯成功後 → 點擊「回測」
  7. 比對XS輸出與Python reference → 計算signal parity


outputs:
  - xs_compile_log.txt
  - connectivity_report.json
    - compile_status: PASS/FAIL
    - signal_parity: 95%+
    - error_list: []


verify:
  - compile_status == PASS
  - signal_parity >= 95%


rollback:
  - 若parity < 95% → 診斷差異 → 修正xs_draft → 重試
  - 若多次失敗 → 標記BLOCKED + 登記CR_OPEN


evidence_ptr: /evidence/connectivity/{run_id}/connectivity_report.json
gate_binding: G-XQ-PARITY


§4.3 Phase 2: 15子系統 Mini Core Four
[ANCHOR:SPLMVP-PHASE-2]
欄位
	內容
	Phase ID
	Phase-2
	名稱
	15子系統 Mini Core Four
	Outcome
	15×4=60份Mini Core Four文檔完成
	Preconditions
	Phase-1 完成（Connectivity Spike通過）
	Inputs
	藍圖SSOT、SRS、ARCH、各子系統定義
	Steps
	依群組順序產出每子系統的SS_README/SS_SRS/SS_ARCH/SS_DELIVER
	Outputs
	/subsystems/{CA-xxx}/mc4/
	Verify
	15×4份文檔存在且完整
	Rollback
	缺任一件 → 補齊後重驗
	EvidencePack Path
	/evidence/mc4/{run_id}/
	Stopline
	任一子系統Mini Core Four不完整 → STOP
	Fail-Closed Behavior
	缺任一件視為子系統不完整
	Handoff Contract
	mc4_manifest.json → Phase-3
	Gate綁定
	G-SCHEMA
	群組編排順序
[ANCHOR:SPLMVP-GROUP-ORDER]
引用藍圖：見 [BP-PHASE-2]
群組
	子系統
	順序
	G1-Spec
	CA-WRC, CA-CORPUS, CA-DISTILL, CA-DSL
	1
	G2-Strategy
	CA-METHOD, CA-BACKTEST
	2
	G3-Execution
	CA-TA, CA-SELECT, CA-TRANSLATE
	3
	G4-Runtime
	CA-WATCH, CA-EXECUTE
	4
	G5-Feedback
	CA-PERFORM
	5
	G6-Cross
	CA-GOVERN, CA-COLLAB, CA-UI
	6
	§4.4 Phase 3: 各子系統WP（單檔三合一）
[ANCHOR:SPLMVP-PHASE-3]
欄位
	內容
	Phase ID
	Phase-3
	名稱
	各子系統WP
	Outcome
	15份WP.Master.md完成
	Preconditions
	Phase-2 完成
	Inputs
	Mini Core Four、P2/P2.5 WP規格母本
	Steps
	依群組順序產出每子系統的WP.Master.md
	Outputs
	/subsystems/{CA-xxx}/wp/WP.Master.md
	Verify
	15份WP存在、Front-Matter完整
	Rollback
	缺任一份 → 補齊後重驗
	EvidencePack Path
	/evidence/wp/{run_id}/
	Stopline
	任一WP不完整 → STOP
	Fail-Closed Behavior
	缺WP.Master.md視為實作包不完整
	Handoff Contract
	wp_manifest.json → Phase-4
	Gate綁定
	G-SCHEMA
	§4.5 Phase 4: GateKit + Regression Suite
[ANCHOR:SPLMVP-PHASE-4]
欄位
	內容
	Phase ID
	Phase-4
	名稱
	GateKit + Regression Suite
	Outcome
	/gates/目錄結構完成、8個Gate模板齊全、GateRunner可執行
	Preconditions
	Phase-3 完成
	Inputs
	藍圖SSOT [BP-8-GATE-TEMPLATES]、討論B最終裁定
	Steps
	Step 4.1 建立/gates/目錄結構；Step 4.2 建立8個Gate模板；Step 4.3 建立GateRunner；Step 4.4 執行Regression Suite
	Outputs
	/gates/目錄、gate_manifest.json
	Verify
	8個Gate模板存在、GateRunner可執行、golden_set通過
	Rollback
	Gate失敗 → 診斷 → 修正 → 重跑
	EvidencePack Path
	/evidence/gates/{run_id}/
	Stopline
	任一Gate模板缺失 → STOP
	Fail-Closed Behavior
	GateKit未落地視為G5未完成
	Handoff Contract
	gate_manifest.json → Phase-5
	Gate綁定
	G-RUN
	§4.6 Phase 5: MVP Spine v1 收束
[ANCHOR:SPLMVP-PHASE-5]
欄位
	內容
	Phase ID
	Phase-5
	名稱
	MVP Spine v1 收束
	Outcome
	15子系統全部通過Gate、E2E smoke成功、acceptance_status = COMPLETE
	Preconditions
	Phase-4 完成
	Inputs
	所有子系統產物、所有Gate報告
	Steps
	Step 5.1 收斂15子系統；Step 5.2 執行E2E smoke；Step 5.3 產生acceptance_status
	Outputs
	spine_v1_manifest.json, acceptance_status.json
	Verify
	15/15子系統PASS、E2E smoke PASS
	Rollback
	任一失敗 → 回退至對應Phase → 修正 → 重跑
	EvidencePack Path
	/evidence/spine_v1/{run_id}/
	Stopline
	任一子系統FAIL → STOP
	Fail-Closed Behavior
	任一子系統未交付視為MVP不完整
	Handoff Contract
	acceptance_status.json → RELEASE
	Gate綁定
	G-RUN
	________________


§5 WI操作卡 + WP單檔制
[ANCHOR:SPLMVP-S5-WI-CARDS]
本節DoD：固定schema、WP模板、T0/T1示範、WI卡ADR說明
§5.1 WI操作卡固定Schema
[ANCHOR:SPLMVP-WI-SCHEMA]
每張WI操作卡必須包含以下欄位：
# WI操作卡固定Schema
wi_id: WI-{STAGE}-{SUBSYS}-{SEQ}
wi_name: 卡片名稱
所屬Stage: Phase-{n} / Step-{m}


inputs:
  - 輸入物1（路徑/格式）
  - 輸入物2


steps:
  1. 步驟1
  2. 步驟2
  3. ...


outputs:
  - 輸出物1（路徑/格式）
  - 輸出物2


verify:
  - 驗證條件1
  - 驗證條件2


rollback:
  - 回滾動作1
  - 回滾動作2


evidence_ptr: /evidence/{subsystem}/{run_id}/{artifact}.json
gate_binding: G-{GATE_ID}
stopline: 停止線條件
fail_closed_behavior: 失敗阻斷行為


§5.2 WP單檔制（Work Package）
[ANCHOR:SPLMVP-WP-TEMPLATE]
§5.2.1 WP定位
WP = Work Package 單檔三合一，整合：
* README（交付物說明）
* Runbook（流程步驟）
* WI（操作指令）
§5.2.2 WP命名規則
/subsystems/{CA-xxx}/wp/WP.Master.md


§5.2.3 WP Front-Matter模板
[ANCHOR:SPLMVP-FRONT-MATTER]
---
wp_id: WP-{SUBSYSTEM}-{VERSION}
wp_name: {子系統名稱} Work Package
subsystem: CA-{XXX}
version: v1.0.0
status: DRAFT | REVIEW | RELEASE
route_mode: T0_DAYTRADE | T1_SWING | BOTH


author: {作者}
reviewer: {審查者}
created_at: YYYY-MM-DD
updated_at: YYYY-MM-DD


inputs:
  - {輸入物1}
  - {輸入物2}


outputs:
  - {輸出物1}
  - {輸出物2}


gate_binding:
  - G-{GATE_ID_1}
  - G-{GATE_ID_2}


evidence_ptr: /evidence/{subsystem}/{run_id}/


dependencies:
  - CA-{上游子系統1}
  - CA-{上游子系統2}


dependencies_with_version:
  - subsystem: CA-{上游子系統1}
    min_version: v1.0.0          # 最低相容版本
    max_version: v2.0.0          # 最高相容版本（可選）
    version_policy: SEMVER       # 版本策略：SEMVER | EXACT | LATEST
  - subsystem: CA-{上游子系統2}
    min_version: v1.0.0
    version_policy: SEMVER


dependency_resolution:
  on_version_mismatch: BLOCK | RADAR_ONLY | AUTO_UPGRADE
  evidence_ptr: /evidence/{subsystem}/dependency_check.json


stopline:
  - {停止線條件1}
  - {停止線條件2}


fail_closed_behavior: {失敗行為}
---


§5.2.4 T0/T1 雙路由示範
[ANCHOR:SPLMVP-T0T1-ROUTE]
---
# T0_DAYTRADE 專屬區塊
route_mode: T0_DAYTRADE
time_constraints:
  entry_cutoff: "13:10"      # 禁新倉
  force_close: "13:20"       # 強制平倉
  rod_only_start: "13:25"    # ROD-only開始
  rod_only_end: "13:30"      # 收盤
position_rule: "當日必清"
---


---
# T1_SWING 專屬區塊
route_mode: T1_SWING
time_constraints:
  entry_window: "09:00-13:25"
  exit_deadline: "次日13:25"
position_rule: "持倉過夜，次日收盤前平倉"
direction_constraint: "只做多"
---


---
# BOTH（共用）區塊
route_mode: BOTH
common_rules:
  - XQ唯一下單端
  - HITL人工確認
  - evidence必產
---


§5.3 Mini Core Four Schema
[ANCHOR:SPLMVP-MINI-CORE-FOUR]
每子系統必須產出四件核心文檔：
文檔ID
	文檔名稱
	職責
	MC4-1
	SS_README.md
	子系統導讀、定位、邊界
	MC4-2
	SS_SRS.md
	子系統需求規格（引用P1_SRS）
	MC4-3
	SS_ARCH.md
	子系統架構（引用P1_ARCH）
	MC4-4
	SS_DELIVER.md
	子系統交付規格、驗收標準
	MC4 Schema
# Mini Core Four Schema
mc4_id: MC4-{SUBSYSTEM}
subsystem: CA-{XXX}
version: v1.0.0


mc4_1_readme:
  path: /subsystems/{CA-xxx}/mc4/SS_README.md
  status: DRAFT | DONE
  
mc4_2_srs:
  path: /subsystems/{CA-xxx}/mc4/SS_SRS.md
  status: DRAFT | DONE
  parent_ref: P1_SRS_v7.0.0
  
mc4_3_arch:
  path: /subsystems/{CA-xxx}/mc4/SS_ARCH.md
  status: DRAFT | DONE
  parent_ref: P1_ARCH_v6.0.0-r5
  
mc4_4_deliver:
  path: /subsystems/{CA-xxx}/mc4/SS_DELIVER.md
  status: DRAFT | DONE
  
completion_status: 0/4 | 1/4 | 2/4 | 3/4 | 4/4
gate_binding: G-SCHEMA


MC4 驗收DoD（Definition of Done）
[ANCHOR:SPLMVP-MC4-DOD]


# MC4-1: SS_README.md 驗收標準
mc4_1_dod:
  file_exists: true
  max_pages: 2                    # 硬上限，超出需裁剪
  required_sections:
    - 子系統ID與名稱
    - 定位與邊界聲明
    - In-Scope / Out-of-Scope
    - 上下游依賴
    - 關鍵術語（若有）
  forbidden_content:
    - 完整實作細節（Route-Out至SS_ARCH）
    - 教學性背景（Route-Out至MethodCard）
  verify_method: |
    1. 檔案存在且可讀
    2. 行數/頁數符合上限
    3. 必填sections存在（grep檢查）
    4. 無forbidden_content（反向grep檢查）
  gate_binding: G-SRC




# MC4-2: SS_SRS.md 驗收標準
mc4_2_dod:
  file_exists: true
  required_sections:
    - 需求引用（parent_ref: P1_SRS_v7.0.0）
    - 子系統專屬需求清單
    - 功能需求 / 非功能需求
    - 驗收標準（AC）
  required_refs:
    - 至少1條引用P1_SRS條目
  forbidden_content:
    - 架構設計細節（Route-Out至SS_ARCH）
    - 數值門檻硬編碼（Route-Out至CR_OPEN）
  verify_method: |
    1. 檔案存在且可讀
    2. parent_ref欄位存在且指向P1_SRS_v7.0.0
    3. 至少有1條需求ID（grep "REQ-*"）
    4. AC區塊存在
  gate_binding: G-SCHEMA




# MC4-3: SS_ARCH.md 驗收標準
mc4_3_dod:
  file_exists: true
  required_sections:
    - 架構引用（parent_ref: P1_ARCH_v6.0.0-r5）
    - 子系統邊界與介面
    - 關鍵元件
    - 資料流
  required_refs:
    - 至少1條引用P1_ARCH/ICD條目
  forbidden_content:
    - 需求條文（Route-Out至SS_SRS）
    - 操作步驟（Route-Out至WP）
  verify_method: |
    1. 檔案存在且可讀
    2. parent_ref欄位存在且指向P1_ARCH_v6.0.0-r5
    3. 介面/元件/資料流區塊存在
  gate_binding: G-SCHEMA




# MC4-4: SS_DELIVER.md 驗收標準
mc4_4_dod:
  file_exists: true
  required_sections:
    - 交付物清單（含路徑）
    - 驗收標準（AC）
    - Gate綁定
    - Evidence路徑範例
  required_fields:
    - deliverable_id
    - deliverable_path
    - acceptance_criteria
    - gate_binding
    - evidence_ptr
  forbidden_content:
    - 架構設計（Route-Out至SS_ARCH）
    - 完整SRS條文（Route-Out至SS_SRS）
  verify_method: |
    1. 檔案存在且可讀
    2. 所有required_fields存在
    3. evidence_ptr格式正確（/evidence/{subsystem}/...）
    4. gate_binding為8個模板之一
  gate_binding: G-SCHEMA




# MC4 整體完成判定
mc4_completion_criteria:
  4_of_4_files_exist: true
  all_dod_passed: true
  no_blocking_issues: true
  completion_evidence: /evidence/{subsystem}/mc4_completion.json


§5.4 關鍵WI操作卡清單
[ANCHOR:SPLMVP-WI-LIST]
WI ID
	名稱
	所屬Stage
	WI-PREFLIGHT-AUTHORITY-001
	建立Authority Stack引用表
	Phase-0
	WI-PREFLIGHT-SCOPELOCK-001
	建立Scope-Lock配置
	Phase-0
	WI-SPINE-SCAFFOLD-001
	建立Spine v0目錄骨架
	Phase-1
	WI-XQ-CONNECTIVITY-SPIKE-001
	XQ/XS v0連接性驗證
	Phase-1
	WI-MC4-BUILD-001
	建立子系統Mini Core Four
	Phase-2
	WI-WP-BUILD-001
	建立子系統WP
	Phase-3
	WI-GATEKIT-BUILD-001
	建立GateKit
	Phase-4
	WI-GATERUNNER-BUILD-001
	建立GateRunner
	Phase-4
	WI-SPINE-V1-COLLECT-001
	收斂15子系統至Spine v1
	Phase-5
	WI-SPINE-V1-ACCEPT-001
	產生acceptance_status
	Phase-5
	WI-EVIDENCE-PACK-001
	產生EvidencePack三件套
	每Phase
	WI-MANIFEST-GEN-001
	產生Manifest
	每Pipeline
	§5.5 ADR-RB-001: WI卡數量縮減說明
[ANCHOR:SPLMVP-ADR-WI]
來源：[SRC:審查報告｜PATCH-RB-003｜DRIFT-003]
adr_id: ADR-RB-001
adr_title: WI卡數量縮減說明
adr_date: 2026-01-16


context: |
  v1.0.0聲明「37張WI卡」，v1.1.0改為「關鍵WI卡」，
  但未提供縮減原因的ADR說明。


decision: |
  v1.3.0採用「關鍵WI卡」策略，保留12張核心WI卡，
  原因如下：
  1. 37張WI卡導致文檔膨脹，違反「最小可用步驟」原則
  2. 部分WI卡可合併為單一WI卡
  3. 部分WI卡屬於Agent/Codex可自動化範疇，不需人工WI


rationale:
  - 遵循Scope-Lock「最小可用步驟」原則
  - 避免WI卡變成"菜單"，最後誰也不照做
  - 保留核心WI卡確保關鍵步驟可稽核


consequences:
  - 12張關鍵WI卡覆蓋Phase 0-5核心步驟
  - 其餘步驟由Agent/Codex自動化
  - 若需恢復完整卡集，可開CR_OPEN


alternatives_considered:
  - 恢復37張完整卡集（rejected: 文檔膨脹）
  - 0張WI卡全靠Agent（rejected: 失去可稽核性）


verification: |
  12張WI卡覆蓋所有Phase的關鍵步驟，
  每張卡包含完整的inputs/steps/outputs/verify/rollback。


status: ACCEPTED
§6 Pipeline與Agent協作規範
[ANCHOR:SPLMVP-S6-PIPELINE]
本節DoD：開發過程/實際使用分離、3 Pipeline定義明確、Agent骨架明確
§6.1 三管線定義（Pipeline A/B/C）
[ANCHOR:SPLMVP-PIPELINE-ABC]
引用藍圖：見 [BP-3-PIPELINES]
三管線不得互相重疊：
Pipeline
	負責人
	Stage
	輸出Pack
	護欄
	A
	媽媽
	WRC/CORPUS/DISTILL/DSL
	SpecPack
	禁止實作、禁止回測、禁止XS
	B-Strategy
	弟弟
	METHOD + BACKTEST
	StrategyPack
	禁止XS轉譯、禁止UI實作
	B-Learn
	弟弟
	POST-INGEST + PERFORM + FEEDBACK
	FeedbackPack
	只提案，不直接改策略
	C
	爸爸
	TA + SELECT + TRANSLATE
	XSPack
	禁止改方法卡、禁止改回測參數
	§6.1.1 Pipeline A: SpecPack產出
[ANCHOR:SPLMVP-SPECPACK]
pipeline_id: Pipeline-A
pipeline_name: SpecPack產出管線
負責人: 媽媽
stage_sequence:
  - CA-WRC
  - CA-CORPUS
  - CA-DISTILL
  - CA-DSL


inputs:
  - ICT_PDF_POINTERS（教材PDF路徑清單）
  - corpus_config.yaml


outputs:
  - SpecPack/<specpack_id>/
    - input_manifest.json
    - corpus_snapshot.json
    - distill_bundle.json
    - dsl_schema.json
    - primitives/


manifest_fields:
  - run_id
  - pipeline_id: A
  - operator
  - inputs[]
  - outputs[]
  - gates[]
  - handoff


handoff_rule: |
  PR: PR-A-SpecPack-<specpack_id>
  合併tag: specpack/<specpack_id>


gate_binding:
  - G-SRC（來源完整性）
  - G-SEG-L（語意保真）
  - G-SCHEMA（結構完整性）


護欄:
  - 禁止實作
  - 禁止回測
  - 禁止XS轉譯


§6.1.2 Pipeline B: StrategyPack產出
[ANCHOR:SPLMVP-STRATEGYPACK]
# B-Strategy
pipeline_id: Pipeline-B-Strategy
pipeline_name: StrategyPack產出管線
負責人: 弟弟
stage_sequence:
  - CA-METHOD
  - CA-BACKTEST


inputs:
  - SpecPack/<specpack_id>（必須引用固定版本）
  - market_data_pointer


outputs:
  - StrategyPack/<strategypack_id>/
    - method_card.md
    - backtest_report.md
    - backtest_artifacts/


manifest_fields:
  - run_id
  - pipeline_id: B-Strategy
  - operator
  - inputs[]
  - outputs[]
  - gates[]
  - handoff


handoff_rule: |
  PR: PR-B-StrategyPack-<strategypack_id>
  合併tag: strategypack/<strategypack_id>


gate_binding:
  - G-BT-H（回測健康度）
  - G-SRC（方法卡完整性）


護欄:
  - 禁止XS轉譯
  - 禁止UI實作


# B-Learn
pipeline_id: Pipeline-B-Learn
pipeline_name: FeedbackPack產出管線
負責人: 弟弟
stage_sequence:
  - POST-INGEST
  - CA-PERFORM
  - FEEDBACK


inputs:
  - XQ_EXPORTS_POINTERS
  - StrategyPack（當時使用的版本）


outputs:
  - FeedbackPack/<feedbackpack_id>/
    - performance_report.md
    - upgrade_proposal.md（只提案）
    - evidence_links.json


特別規則: |
  FeedbackPack僅允許輸出proposal，
  不允許直接改method_card定案。
  策略變更必須經過「回測定案」關卡。


gate_binding:
  - PERFORM-Gate


§6.1.3 Pipeline C: XSPack產出
[ANCHOR:SPLMVP-XSPACK]
pipeline_id: Pipeline-C
pipeline_name: XSPack產出管線
負責人: 爸爸
stage_sequence:
  - CA-TA
  - CA-SELECT
  - CA-TRANSLATE


inputs:
  - SpecPack + StrategyPack（必須引用固定版本）
  - market_data_pointer


outputs:
  - XSPack/<xspack_id>/
    - xs_script.txt
    - xs_script_pack.json
    - watchlist.csv
    - stock_story_cards/
    - import_instructions.md


manifest_fields:
  - run_id
  - pipeline_id: C
  - operator
  - inputs[]
  - outputs[]
  - gates[]
  - handoff


handoff_rule: |
  PR: PR-C-XSPack-<xspack_id>
  合併tag: xspack/<xspack_id>


gate_binding:
  - G-CONF-L（覆蓋率/信賴度）
  - G-XQ-PARITY（XQ一致性）
  - G-HITL-LOG（HITL日誌）


護欄:
  - 禁止改方法卡
  - 禁止改回測參數


§6.2 交接規則總表
[ANCHOR:SPLMVP-HANDOFF-RULES]
規則
	說明
	Pack不可變
	所有Pack以版本號+hash命名，禁止覆寫
	交接認證
	只認manifest裡列出的輸入/輸出與hash
	交接媒介
	只靠PR/tag/release note，不靠聊天貼檔
	Pipeline互不越界
	A不做回測、B不做XS、C不改方法卡
	完整交付
	每次交接必須是「完成一個Pack」
	審核機制
	PR審核可由第三方AI（或指定Reviewer）執行
	Handoff Artifact欄位
[ANCHOR:SPLMVP-HANDOFF-ARTIFACT]
# Handoff Artifact Schema v1.1.0
handoff_id: HO-{pipeline_id}-{run_id}
source_pipeline: Pipeline-{A|B|C}
target_pipeline: Pipeline-{A|B|C}
handoff_type: PACK_COMPLETE | REVIEW_REQUEST | MERGE_READY




artifacts:
  - artifact_id: {唯一ID}
    artifact_path: /path/to/artifact
    artifact_hash: sha256:{hash}
    artifact_type: SpecPack | StrategyPack | XSPack | FeedbackPack




manifest_ref: /manifest/{run_id}/manifest.json
gate_report_ref: /evidence/{run_id}/gate_report.json




handoff_status: PENDING | APPROVED | REJECTED | TIMEOUT | RETRY
reviewer: {審查者}
review_timestamp: YYYY-MM-DDTHH:MM:SSZ




# [PATCH-004] 新增欄位（v1.2.1補丁）
timeout_config:
  timeout_sec: 3600          # 交接超時秒數（默認1小時）
  max_retry: 3               # 最大重試次數
  retry_interval_sec: 300    # 重試間隔秒數（默認5分鐘）
  escalation_on_timeout: HITL  # 超時升級處置（HITL/AUTO_REJECT/QUEUE）




retry_history:
  - retry_count: {當前重試次數}
    retry_reason: {重試原因}
    retry_timestamp: YYYY-MM-DDTHH:MM:SSZ




timeout_behavior:
  on_timeout: |
    1. 記錄 timeout_log 至 /evidence/{run_id}/handoff_timeout.json
    2. 若 retry_count < max_retry → 觸發重試
    3. 若 retry_count >= max_retry → 升級至 escalation_on_timeout
    4. HITL升級：發送通知 + 等待人工決定
    5. AUTO_REJECT升級：自動標記 REJECTED + 阻斷下游
    6. QUEUE升級：放入待處理佇列 + 不阻斷但標記 RADAR_ONLY




fail_closed_behavior:
  - 超過max_retry且無HITL介入 → BLOCK下游Pipeline
  - 必須記錄完整retry_history
  - 產生 /evidence/{run_id}/handoff_final_status.json




§6.3 Agent開發過程規約（Dev Context - 開發過程工具規劃）
[ANCHOR:SPLMVP-AGENT-DEV]
⚠️ **DEV CONTEXT ONLY** - 本節僅適用於「開發過程+實作」，與Ops情境嚴格分離，禁止與「實際使用」混寫
§6.3.1 Agent提速點
[ANCHOR:SPLMVP-AGENT-SPEEDUP]
提速點
	工具
	職責
	審核點
	落地鏈路自動化
	Claude Code
	多檔改動+測試+產出diff/PR
	Code Review
	批量檔案處理
	Codex CLI
	批量重命名/格式化/schema驗證
	Schema校驗
	雲端沙盒環境
	Codespaces
	隔離執行環境+算力支援
	資源監控
	跨LLM蒸餾
	多AI協作
	4家盲產→2家盲產+整合
	HITL裁決
	§6.3.2 Codespaces規劃
[ANCHOR:SPLMVP-CODESPACES]
# Codespaces配置
codespaces_role: 雲端工作站
primary_tasks:
  - 蒸餾
  - 小規模回測
  - TA計算
  - 選股
  - XS轉譯


降級觸發條件:
  - Codespaces不可用 → 切換至MANUAL模式
  - 算力不足 → 降級至本地執行
  - 網路問題 → 離線模式


降級策略:
  - 保留相同pipeline腳本
  - 切換ExecutionBackend參數
  - 輸出相同artifact/evidence結構


§6.3.3 Claude Code規劃
[ANCHOR:SPLMVP-CLAUDE-CODE]
# Claude Code角色
claude_code_role: 主控Agent（開發過程）
primary_tasks:
  - 編排任務
  - 拉資料
  - 跑pipeline
  - 產出evidence


工作方式:
  - diff/PR驅動
  - 測試驅動
  - 回歸驗證
  - 最小可重跑證據


權限模式:
  - 只讀：market_data/、config/
  - 讀寫：artifact/、evidence/、outputs/
  - 禁止：credentials/、secrets/


§6.3.4 AGENTS.md骨架
[ANCHOR:SPLMVP-AGENTS-MD]
# AGENTS.md


## 角色定義
- Claude Code: 主控Agent
- Codex: 修補Agent
- Gemini: 盲審Agent


## 權限矩陣
| Agent | 讀取 | 寫入 | 執行 | 審核 |
|-------|------|------|------|------|
| Claude Code | ✅ | ✅ | ✅ | ❌ |
| Codex | ✅ | ✅ | ✅ | ❌ |
| Gemini | ✅ | ❌ | ❌ | ✅ |


## 危險命令清單
- rm -rf
- git push --force
- 任何涉及credentials的命令


## 審批流程
1. 危險命令 → HITL審批
2. 憑證操作 → BLOCK


## Evidence產出規則
- 每次執行必產manifest.json
- 每次執行必產gate_report.json
- 每次執行必產run_log.md


## 命令白名單/黑名單
[ANCHOR:SPLMVP-AGENTS-COMMAND-ACL]


### 白名單（允許Agent直接執行）
| 分類 | 命令模式 | 說明 |
|------|----------|------|
| Git讀取 | `git status`, `git log`, `git diff`, `git branch` | 僅讀取操作 |
| Git寫入 | `git add`, `git commit`, `git push`（非force） | 標準提交流程 |
| npm/yarn | `npm install`, `npm run build`, `npm test`, `yarn add` | 依賴與建置 |
| Python | `python -m pytest`, `pip install --break-system-packages` | 測試與依賴 |
| 讀取類 | `cat`, `ls`, `grep`, `find`, `head`, `tail`, `wc` | 檔案讀取 |
| JSON處理 | `jq`, `json_pp` | 結構化數據處理 |
| Schema驗證 | `ajv validate`, `jsonschema` | Schema校驗 |


### 黑名單（禁止Agent執行，違反即BLOCK）
| 分類 | 命令模式 | 違反後果 |
|------|----------|----------|
| 危險刪除 | `rm -rf`, `rm -r /`, `rmdir --ignore-fail-on-non-empty` | BLOCK + 記錄incident |
| 強制推送 | `git push --force`, `git push -f`, `git reset --hard origin/*` | BLOCK + 需HITL審批 |
| 權限操作 | `sudo *`, `su *`, `chmod 777`, `chown root` | BLOCK |
| 憑證訪問 | `cat credentials/*`, `cat secrets/*`, `cat *.pem`, `cat *.key` | BLOCK + 記錄security_alert |
| 網路濫用 | `curl POST *` 到非白名單域、`wget --mirror` | BLOCK |
| 系統級 | `shutdown`, `reboot`, `kill -9 1`, `systemctl stop` | BLOCK |
| 環境變數洩漏 | `env | grep KEY`, `printenv SECRET`, `echo $API_KEY` | BLOCK |


### 灰名單（需HITL審批後執行）
| 分類 | 命令模式 | 審批流程 |
|------|----------|----------|
| Git合併 | `git merge`, `git rebase` | 產生PR → HITL審批 → 執行 |
| 發布類 | `npm publish`, `pip upload`, `docker push` | 需明確HITL確認 |
| Evidence刪除 | `rm /evidence/*` | 需記錄刪除原因 + HITL確認 |
| 配置變更 | 修改 `config/*.yaml`, `.env` | 需diff審核 + HITL確認 |
| 外部API調用 | 非白名單域的HTTP請求 | 需HITL審批域名 |


### 白名單域名（允許網路訪問）
github.com 
api.github.com 
registry.npmjs.org 
pypi.org 
files.pythonhosted.org

### 違反處置流程
1. Agent執行命令前，Runner檢查ACL
2. 若命中黑名單 → 立即BLOCK + 記錄 `/evidence/{run_id}/acl_violation.json`
3. 若命中灰名單 → 暫停執行 + 發送HITL審批請求
4. 審批超時（默認30分鐘）→ 視為REJECT
5. 違反記錄納入 `gate_report.json` 的 `security_checks` 欄位


§6.3.5 CLAUDE.md骨架
[ANCHOR:SPLMVP-CLAUDE-MD]
# CLAUDE.md


## 專案上下文
- 專案名稱: Spartoi
- 版本: SubP1-LITE+MVP v1.3.0
- SSOT: 藍圖v1.2.1 + RUNBOOK v1.4.0


## 工作規則
1. 先讀RUNBOOK §1 Charter
2. 遵守Authority Stack（引用藍圖）
3. 每步驟必產evidence


## 禁止事項
- 禁止自創Gate類別
- 禁止修改Authority Stack
- 禁止繞過HITL
- 禁止操作credentials


## Slash Commands
- /run_pipeline {pipeline_id}
- /generate_evidence {run_id}
- /verify_gate {gate_id}
- /create_manifest {pack_id}


§6.3.6 安全規約
[ANCHOR:SPLMVP-AGENT-SECURITY]
安全項目
	規則
	權限模式
	Agent權限需控制，禁止全自動+任意命令
	危險命令審批
	rm -rf、force push → HITL審批
	資料隔離
	credentials/secrets/ → Agent禁止訪問
	憑證隔離
	OAuth token/API key → 環境變數/GitHub Secrets
	下單端隔離
	XQ下單端 → 不可搬上雲端
	

§6.3.7 Claude Cowork整合（Dev）
[ANCHOR:SPLMVP-COWORK-DEV]


**引用藍圖**：[BP-COWORK-POSITIONING-V121]


⚠️ 本節僅適用於「開發過程」，Ops情境禁用Cowork


#### 定位
Cowork僅限Dev情境的「非代碼資產處理」


#### 允許操作
| 操作類型 | 說明 | 輸出要求 |
|---|---|---|
| 文件整理 | 整理草稿、歸檔 | → staging區 |
| 格式轉換 | MD↔DOCX、JSON格式化 | → staging區 |
| 草稿生成 | 初版文件草稿 | → staging區 |
| 資料抽取 | 從外部文件抽取結構化資料 | 需經Sanitizer |


#### 禁止操作
| 禁止項 | 原因 | 違反處置 |
|---|---|---|
| 直接覆寫SSOT | 繞過Gate審核 | BLOCK_RELEASE |
| 執行破壞性操作 | 需Destructive兩段式 | BLOCK_RELEASE |
| Ops任務 | Ops預設禁用Cowork | BLOCK_RELEASE |
| PASS/FAIL判定 | Skills不得當裁判 | 移除判定 |


#### 輸出規範
- 所有Cowork輸出必須進staging區
- staging區路徑：`/staging/{run_id}/`
- 經Gate PASS後才可合併主線


#### Evidence要求
```yaml
cowork_evidence:
  cowork_used: true
  cowork_task_type: "document_organization|format_conversion|draft_generation"
  input_trust_tier: L0|L1|L2  # L3禁止進入Cowork
  output_staging_path: /staging/{run_id}/
  gate_passed: true|false
```


§6.3.8 Agent Skills整合（Dev）
[ANCHOR:SPLMVP-SKILLS-DEV]


**引用藍圖**：[BP-SKILLS-POSITIONING-V121]


#### 定位
Skills為工作流封裝機制，用於可重複任務自動化


#### 允許操作
| 操作類型 | 說明 | Gate綁定 |
|---|---|---|
| 封裝可重複任務 | 將WI卡工序封裝為Skill | G-RUN |
| 自動化GateKit執行 | Skills觸發GateRunner | G-RUN |
| Pipeline護欄 | 三管線品質檢查 | 對應Pipeline Gate |
| Schema驗證 | 結構化輸出驗證 | G-SCHEMA |


#### 「不得當裁判」原則
- Skills角色：製作工（產成品/整理/組裝）
- Skills禁止：判定PASS/FAIL
- PASS/FAIL判定：一律回到GateKit/GateRunner
- 違反處置：移除判定，走Gate審核


#### 三管線嵌入點
| Pipeline | Skills用途 | Gate驗證 |
|---|---|---|
| Pipeline A (SpecPack) | 輔助SpecPack整理 | G-SCHEMA |
| Pipeline B (StrategyPack) | 輔助回測報告格式化 | G-BT-H |
| Pipeline C (XSPack) | 輔助XSPack打包 | G-XQ-PARITY |


#### MVS（Minimum Viable Skills）
v1.2.1定案的唯一Skill：**spartoi-schema**


| Skill ID | 用途 | 狀態 |
|---|---|---|
| spartoi-schema | Schema驗證 | **定案** |
| spartoi-evidencepack-builder | 三件套組裝 | CR_OPEN候選 |
| spartoi-gatekit-runner | Gate執行 | CR_OPEN候選 |


完整清單：見§6.9 MVS定義


#### Evidence要求
```yaml
skills_evidence:
  skills_used:
    - skill_id: spartoi-schema
      skill_version: v1.0.0
      trigger_reason: "manifest validation"
  skills_output_staging_path: /staging/{run_id}/
  gate_verification: PASS|FAIL|PENDING
```
§6.3.8.1 Skills Integration執行規格 (v1.3.0補丁)


[ANCHOR:SPLMVP-SKILLS-EXEC-V140]


**執行層規格（引用藍圖[BP-SKILLS-CONSTRAINTS-V121]）**


##### 執行前檢查清單


```yaml
pre_execution_checklist:
  - skill_id已在允許清單：見藍圖§9.6.1
  - 輸出路徑=staging/skills/{skill_id}/{run_id}/
  - input_trust_tier ≤ L2
  - 無敏感檔案在授權目錄


執行後驗收
post_execution_verify:
  - min_artifacts存在：report.md + result.json + 特定產物
  - 無PASS/FAIL字樣在skill輸出
  - staging目錄權限正確


Gate觸發
gate_trigger:
  consumer: 見藍圖Skills I/O統一規格
  timing: Skill執行完成後自動
  failure_action: 見藍圖failure_degradation欄位


引用點
* 規範定義SSOT：藍圖[BP-SKILLS-CONSTRAINTS-V121]
* 本節為執行SOP，不重複定義規範


#### §6.3.8.2 四大高槓桿Skills執行指引
[ANCHOR:SPLMVP-SKILLS-FOUR-V140]


##### 優先順序


| 優先級 | Skill ID | 失敗模式 | 說明 |
|--------|----------|----------|------|
| 1 | spartoi-evidencepack-builder | HITL降級 | 最高優先 |
| 2 | spartoi-gatekit-runner | BLOCK降級 | |
| 3 | spartoi-authority-scope-lock | HITL降級 | |
| 4 | spartoi-pipeline-guardrails | BLOCK降級 | |


##### 統一I/O契約


| Skill ID | 輸入 | 輸出目錄 | 必備產出 |
|----------|------|----------|----------|
| evidencepack-builder | manifest.json, artifacts/* | staging/skills/evidencepack-builder/{run_id}/ | report.md, result.json, evidence_ptrs.json |
| gatekit-runner | gate_spec.yaml, inputs/* | staging/skills/gatekit-runner/{run_id}/ | gate_report.json, pass_fail.json, log.txt |
| authority-scope-lock | scope_lock.yaml, changes/* | staging/skills/authority-scope-lock/{run_id}/ | drift_report.json, violations.json |
| pipeline-guardrails | pipeline_spec.yaml, handoff/* | staging/skills/pipeline-guardrails/{run_id}/ | guardrail_report.json, boundary_check.json |


##### 執行範例
```bash
# evidencepack-builder 執行範例
run_id=$(date +%Y%m%d_%H%M%S)
mkdir -p staging/skills/evidencepack-builder/${run_id}


# 執行技能後驗證輸出
ls staging/skills/evidencepack-builder/${run_id}/
# 預期：report.md result.json evidence_ptrs.json


# 若缺少任一檔案 → 觸發失敗處置
```


##### 失敗處置表


| skill_id | failure_mode | action | CR_OPEN_ref |
|----------|--------------|--------|-------------|
| evidencepack-builder | HITL | 標記INCOMPLETE，人工補齊 | CR_OPEN-019 |
| gatekit-runner | BLOCK | BLOCK_RELEASE，登記CR_OPEN | CR_OPEN-021 |
| authority-scope-lock | HITL | 標記NEEDS_REVIEW，人工裁決 | CR_OPEN-021 |
| pipeline-guardrails | BLOCK | BLOCK_RELEASE，標記越界點 | CR_OPEN-021 |


##### 禁止行為（引用藍圖 [BP-SKILLS-CONSTRAINTS-V121]）


| 禁止項 | 說明 |
|--------|------|
| Skills直接宣告PASS/FAIL | 裁判權屬於GateKit |
| Skills輸出直接變Normative | 必須經Gate驗證 |
| Skills取代GateRunner | 定位是製作工，不是裁判 |




§6.3.9 Tooling Integration Matrix
[ANCHOR:SPLMVP-TOOLING-MATRIX]


**引用藍圖**：[BP-TOOLING-MATRIX-V121]


#### 工具整合矩陣（Dev情境）


| scenario | tool_combo | does | not_do | outputs | hitl_stopline | gate_binding | scope_guard | verification_status |
|---|---|---|---|---|---|---|---|---|
| Dev | Cowork+Claude Code | 文件整理、格式轉換 | 直接覆寫SSOT、Ops任務 | staging/{run_id}/ | 破壞性操作需HITL | G-RUN | TW-008 | Verified |
| Dev | Skills+GateRunner | Schema驗證、Pipeline護欄 | PASS/FAIL判定 | gate_report.json | Skills輸出需Gate | G-SCHEMA | TW-009 | Verified |
| Dev | Cowork+Codespaces | 非SSOT文件處理 | 直接推送、無staging | staging/{run_id}/ | 任何推送需PR審核 | G-RUN | TW-008 | Verified |
| Dev | Claude Code+Codex | 盲產協作 | 無manifest交接 | branch/PR | 合併需Integrator審核 | G-SCHEMA | TW-010 | Verified |
| Dev | Skills+Pipeline | 三管線自動化 | 跳過Gate | evidence/{run_id}/ | Gate FAIL即BLOCK | 對應Gate | TW-009 | Verified |


#### NOT DO清單（平台化禁止項）
- ❌ 儀表板監控Cowork活動
- ❌ 排程中心協調Skills執行
- ❌ 權限矩陣管理Agent能力
- ❌ SIEM整合即時稽核
- ❌ Cowork取代GateRunner
- ❌ Skills輸出直接變Normative




§6.4 Agent實際使用規約（Ops Context - 實際使用工具規劃）
[ANCHOR:SPLMVP-AGENT-OPS]
⚠️ **OPS CONTEXT ONLY** - 本節僅適用於「開發後的實際使用」，Cowork預設禁用，禁止與「開發過程」混寫
§6.4.1 日常工作流
[ANCHOR:SPLMVP-DAILY-WORKFLOW]


# Daily Workflow with Verification Points
daily_workflow:
  - step_id: DW-01
    action: 把ICT PDF丟進Drive指定資料夾
    verify:
      - PDF檔案存在於 /drive/ict_inbox/
      - 檔案格式為PDF且可讀取
    evidence_ptr: /evidence/daily/{date}/dw01_upload_check.json
    rollback: 若上傳失敗 → 重新上傳或標記SKIP


  - step_id: DW-02
    action: 本地排程（或n8n）觸發：同步到雲端沙盒
    verify:
      - 同步任務觸發紀錄存在
      - 雲端沙盒可訪問且檔案已同步
      - hash比對一致
    evidence_ptr: /evidence/daily/{date}/dw02_sync_log.json
    rollback: 若同步失敗 → 重試3次 → 切換至local-manual模式


  - step_id: DW-03
    action: |
      Claude Code（主控）跑一條pipeline：
      - 蒸餾 → 原語/偽代碼 → 方法草案 → 回測 → 方法定案
      - 技術分析/選股 → XS轉譯 → 產出xs_script_pack
    verify:
      - Pipeline執行完成（exit_code=0）
      - manifest.json + gate_report.json 產出
      - 所有Gate狀態非FAIL（或有RADAR_ONLY標記）
      - xs_script_pack存在且XS可編譯
    evidence_ptr: /evidence/daily/{date}/dw03_pipeline_report.json
    rollback: 若Pipeline失敗 → 檢查gate_report → 修復 → 重跑


  - step_id: DW-04
    action: 把XS語法匯入XQ（盤中手動HITL確認進場）
    verify:
      - XS已匯入XQ（編譯成功）
      - HITL確認紀錄存在（hitl_handoff.json）
      - 進場時間符合T0/T1時序規則
    evidence_ptr: /evidence/daily/{date}/dw04_hitl_confirm.json
    rollback: 若匯入失敗 → 檢查XS語法 → 修正 → 重新匯入
    stopline: 無HITL紀錄 → 禁止進場


  - step_id: DW-05
    action: 盤後把XQ匯出的盯盤/操盤/績效檔案丟回Drive
    verify:
      - XQ匯出檔案存在
      - 檔案已上傳至 /drive/xq_export/
      - hash記錄於evidence
    evidence_ptr: /evidence/daily/{date}/dw05_export_check.json
    rollback: 若匯出失敗 → 手動從XQ匯出 → 上傳


  - step_id: DW-06
    action: Claude Code再跑：績效分析 → 方法升級草案 → 回測 → 新版方法定案
    verify:
      - 績效分析報告產出（perf_summary.json）
      - 方法升級草案有回測支撐
      - 新版method_card_version遞增
      - 回測通過G-BT-H Gate
    evidence_ptr: /evidence/daily/{date}/dw06_feedback_report.json
    rollback: 若分析失敗 → 保留原方法 → 登記CR_OPEN


workflow_completion_check:
  all_steps_verified: true
  evidence_complete: true
  no_blocking_issues: true




§6.4.2 第三方AI/LLM驗收
[ANCHOR:SPLMVP-3RD-PARTY-REVIEW]
# 第三方驗收流程
reviewer_prompt_template:
  - 角色：第三方驗收官
  - 輸入：AGENTS.md + manifest.json + 3-5個關鍵evidence檔
  - 任務：
    - 讀manifest
    - Gate報告是否覆蓋要求節點
    - evidence_ptr是否能追到對應檔案
    - MethodCard變更是否有對應回測證據
  - 輸出：缺陷清單 + 對應evidence路徑 + 是否阻擋合併


prompt_versioning:
  prompt_version: v1.0.0
  prompt_id: REVIEWER-PROMPT-001
  effective_date: 2026-01-16
  
  version_history:
    - version: v1.0.0
      date: 2026-01-16
      changes: 初版發布
      
  upgrade_policy:
    on_prompt_change: |
      1. 版本號遞增（SEMVER）
      2. 記錄變更內容至version_history
      3. 舊版prompt保留於 /prompts/archive/
      4. evidence中記錄使用的prompt_version
      
  evidence_fields:
    - prompt_version_used: v1.0.0
    - prompt_hash: sha256:{hash}


MRP_content:
  - manifest.json
  - gate_report.json
  - artifacts/
  - evidence/
  - diff/


§6.4.3 多跨LLM協作流程
[ANCHOR:SPLMVP-MULTI-LLM]
盲產（多家）
├── Codex → branch/PR
├── Claude Code → branch/PR
└── Gemini → branch/PR


一家整合（Integrator）
└── Codex Web → 對照manifest → 合併 → PR


多家審（Reviewer）
├── @codex review
└── /verify_evidence


一家最終整合（Final Integrator）
└── 把review comments轉成修補任務


§6.4.4 Ops Cowork禁用宣告
[ANCHOR:SPLMVP-AGENT-OPS-COWORK-BAN]


**引用藍圖**：[BP-OPS-CONTEXT-V121]


⚠️ **Ops情境預設禁用Cowork - BLOCK_RELEASE條款**


#### 禁用宣告
```yaml
ops_cowork_policy:
  ops_default_no_cowork: true
  enforcement: BLOCK_RELEASE
  status: ACTIVE
```


#### 違反偵測
- Ops情境若檢測到Cowork使用 → BLOCK_RELEASE
- 偵測方式：Evidence manifest中cowork_used=true且context=ops
- 處置：阻斷發布、回滾、登記incident


#### 啟用例外條件
```yaml
enable_condition:
  all_of:
    - G-SEC-PASS
    - G-EVID-PASS
    - HITL_POLICY_PASS
    - CR_OPEN-024_CLOSED  # 目前未關閉
```


目前CR_OPEN-024未關閉 → Ops禁用Cowork**持續生效**


#### 已驗證Skills允許清單
Ops僅可使用經G-RUN驗證的Spartoi專屬Skills：
- spartoi-schema（定案）
- 其他需經CR_OPEN流程新增


#### Evidence欄位
```yaml
ops_cowork_evidence:
  cowork_used: false  # Ops必須為false
  context: ops
  violation_check: PASS|FAIL
```


§6.5 Agent/非Agent一鍵切換
[ANCHOR:SPLMVP-AGENT-TOGGLE]
# Runner抽象層
runner_abstraction:
  backend_options:
    - AGENT: codespaces（雲端算力）
    - MANUAL: local-manual（降級容災）


toggle_config:
  ExecutionBackend: codespaces | local-manual

# Entrypoint Mapping（讓新接手 AI 不會走錯門）
[ANCHOR:SPLMVP-ENTRYPOINT-MAP-v140]


| 用途 | Entrypoint（預設） | Fallback | 輸入 | 必產輸出（最小） | Fail-Closed 檢查 |
|---|---|---|---|---|---|
| 系統閉環主路徑（Orchestrator） | `./scripts/entrypoint.sh --job-spec jobs/<name>.job.yaml` | 若 Orchestrator 未落地 → 轉 MinImpl 先跑通 | JobSpec YAML（見附錄C） | `manifest.json` `gate_report.json` `verdict.json` `orchestration_log.json` | 找不到 `./scripts/entrypoint.sh` 但宣告 runner=orchestrator → **BLOCK_RELEASE** |
| 連通性/最小閉環（Spine v0 MinImpl） | `mvp_spine_v0_minimpl/executable_pack/entrypoint.sh pre_xq --run_id <id>` | N/A | `--run_id` + post_xq 的 `manual_xq/*` | `manifest.json` `gate_report.json` `verdict.json(最小)` `verification_audit.json` | `manual_xq/` 空且宣告 post_xq → verdict=FAIL（exit non-zero） |


**落地硬規則：**
- 選用入口必須寫入 `manifest.json.backend` 與 `verdict.json.backend`（至少含 `execution_backend`、`runner`）。
- fallback 不是偷懶，是“可回放容災”；未記錄 fallback 視同**不合規**（因為你把真相藏起來了）。
  
toggle_ui:
  - CA-UI Toggle開關
  - 切換後寫入evidence/manifest.json


evidence_fields:
  - backend: codespaces | local-manual
  - input_hash: sha256:xxx
  - output_hash: sha256:xxx
  - failure_reason: null | {原因}


failover_runbook: |
  1. 偵測Codespaces不可用
  2. 自動切換至local-manual
  3. 執行相同pipeline腳本
  4. 輸出相同artifact/evidence結構
  5. 記錄backend=local-manual於manifest


§6.5.2 降級路徑context擴充


| backend | context | 觸發條件 | Cowork可用 | Skills可用 |
|---|---|---|---|---|
| codespaces | Dev | 正常開發 | ✅ 受限 | ✅ 已驗證 |
| codespaces | Ops | 正常使用 | ❌ 禁用 | ✅ 已驗證 |
| local-manual | Dev | Codespaces不可用 | ❌ | ❌ |
| local-manual | Ops | Codespaces不可用 | ❌ | ❌ |


Evidence欄位擴充：
```yaml
toggle_evidence:
  backend: codespaces|local-manual
  context: dev|ops
  cowork_available: true|false
  skills_available: true|false
```


§6.6 Input Trust Tier操作規範
[ANCHOR:SPLMVP-INPUT-TRUST-TIER]


**引用藍圖**：[BP-INPUT-TRUST-TIER]


§6.6.1 信任分級定義


| Tier | 定義 | 來源範例 | Cowork權限 | Skills權限 | Claude Code權限 |
|---|---|---|---|---|---|
| L0 (Trusted) | 內部產出、已驗證 | Evidence Pack、已合併PR | read/write/transform | read/write/transform | read/write/transform |
| L1 (Internal) | 內部未驗證 | 草稿、staging區 | read/transform | read/transform | read/write/transform |
| L2 (External-sanitized) | 外部已淨化 | 經sanitizer工序的外部文件 | read-only | read-only | read/transform |
| L3 (Untrusted) | 外部未淨化 | 任意外部文件 | **reject** | **reject** | read-only（警示） |


§6.6.2 信任分級判定流程
輸入來源識別 
↓ 
判定Tier
↓ 
┌─────┴─────┐ 
│         │ 
Tier<L3 Tier=L3
↓        ↓ 
可處理 拒收或Sanitizer
判定規則：
- 來自Evidence Pack → L0
- 來自staging區 → L1
- 經Sanitizer處理 → L2
- 外部未處理 → L3


§6.6.3 Sanitizer工序
[ANCHOR:SPLMVP-INPUT-SANITIZATION]


**引用藍圖**：[BP-INPUT-SANITIZATION]
```yaml
sanitizer_workflow:
  input: L3 Untrusted文件
  process:
    - 抽取純資料
    - 移除隱藏指令（OLE objects、macros、embedded scripts）
    - 驗證格式完整性
  output:
    - L2 External-sanitized文件
    - sanitizer_report.json
  output_path: /staging/{run_id}/sanitized/
```


§6.6.4 拒收機制
[ANCHOR:SPLMVP-INPUT-REJECT]
```yaml
reject_policy:
  trigger: L3文件嘗試進入Cowork/Skills
  action: 自動拒收
  log_path: /evidence/{run_id}/input_reject_log.json
  followup:
    - 登記CR_OPEN
    - 或走Sanitizer工序
```


§6.6.5 Evidence欄位擴充


manifest.json新增欄位：
```json
{
  "input_trust_tier": "L0|L1|L2|L3",
  "sanitizer_applied": true|false,
  "sanitizer_report_ptr": "/evidence/{run_id}/sanitizer_report.json"
}
```


§6.7 Staging-only規範
[ANCHOR:SPLMVP-STAGING-ONLY]


**引用藍圖**：[BP-STAGING-ONLY-SPEC]


**Gate分類**：歸類於 G5-C Artifact Contract


§6.7.1 目錄結構
/staging/ 
├── {run_id}/ 
│ ├── staging_manifest.json 
│ ├── outputs/ 
│ │ └── {輸出檔案} 
│ └── pending_approval.flag


§6.7.2 命名規則
`staging_{YYYY-MM-DD}_{run_id}_{seq}`


範例：`staging_2026-01-18_run-001_001`


§6.7.3 輸出物規則


| 規則 | 說明 |
|---|---|
| 強制staging | 所有Cowork/Skills輸出必須先落地至staging |
| 禁止直接覆寫 | staging區檔案不得直接覆寫SSOT |
| 保留期限 | 7天（經Gate後可清理） |
| 自動標記 | staging區檔案自動標記為L1 |
| 升級條件 | 經Gate PASS後升級為L0並可合併主線 |


§6.7.4 禁止直接覆寫SSOT宣告
Cowork產出 → staging → Gate → HITL approve → 合併SSOT
⚠️ **任何繞過staging的覆寫 → BLOCK_RELEASE**


§6.7.5 staging_manifest.json Schema
```json
{
  "run_id": "staging_2026-01-18_run-001_001",
  "created_at": "2026-01-18T10:00:00Z",
  "source_tool": "cowork|skills|claude_code",
  "input_trust_tier": "L0|L1|L2",
  "outputs": [
    {
      "file_path": "./outputs/draft.md",
      "file_hash": "sha256:xxx",
      "status": "pending_approval"
    }
  ],
  "gate_status": "PENDING|PASS|FAIL",
  "merge_approved": false
}
```


§6.7.6 Evidence欄位
```yaml
staging_evidence:
  staging_status: PENDING|APPROVED|MERGED|REJECTED
  staging_path: /staging/{run_id}/
  gate_report_ptr: /evidence/{run_id}/gate_report.json
```


§6.8 Destructive兩段式規範
[ANCHOR:SPLMVP-DESTRUCTIVE-TWO-PHASE]


**引用藍圖**：[BP-DESTRUCTIVE-TWO-PHASE]


**Gate分類**：歸類於 G5-D Data Integrity


§6.8.1 適用操作


| 操作類型 | 說明 | 必須兩段式 |
|---|---|---|
| OVERWRITE | 覆寫既有檔案 | ✅ |
| DELETE | 刪除檔案 | ✅ |
| BATCH_MOVE | 批次移動檔案 | ✅ |
| TRANSFORM | 格式轉換（破壞原始） | ✅ |


§6.8.2 第一段：產生變更清單
```json
// change_manifest.json
{
  "run_id": "run-xxx",
  "phase": 1,
  "operation_type": "OVERWRITE|DELETE|MOVE|TRANSFORM",
  "target_files": [
    {
      "file_path": "/path/to/file",
      "current_hash": "sha256:xxx",
      "planned_action": "MODIFY|DELETE|CREATE"
    }
  ],
  "expected_outcome": "description of expected result",
  "rollback_plan": "description of rollback steps",
  "diff_preview": "inline diff or pointer to diff file"
}
```


§6.8.3 第二段：人核准後執行
```json
// hitl_approval.json
{
  "run_id": "run-xxx",
  "phase": 2,
  "approver_id": "human-001",
  "approval_timestamp": "2026-01-18T10:30:00Z",
  "approval_notes": "Reviewed and approved",
  "change_manifest_hash": "sha256:xxx"
}
```


執行後產生：
- `execution_report.json`：執行結果記錄
- `rollback_package/`：可回滾工件包


§6.8.4 可回滾工件要求
/rollback/{run_id}/ 
├── pre_snapshot/ 
│ └── {原始檔案備份} 
├── diff_report.json 
└── rollback_script.sh


§6.8.5 Gate掛鉤


- Destructive操作必須綁定 **G-HITL-LOG**
- Gate檢查項：
  - hitl_approval.json存在
  - 核准時間戳可追溯
  - change_manifest_hash匹配
- 缺少核准 → **BLOCK_RELEASE**


§6.8.6 Evidence欄位
```yaml
destructive_evidence:
  operation_type: OVERWRITE|DELETE|MOVE|TRANSFORM
  change_manifest_ptr: /evidence/{run_id}/change_manifest.json
  hitl_approval_ptr: /evidence/{run_id}/hitl_approval.json
  rollback_package_ptr: /rollback/{run_id}/
  execution_status: SUCCESS|FAILED|ROLLED_BACK
```

§6.8.7 Solo-Mode HITL操作規範
[ANCHOR:SPLMVP-SOLO-HITL-OPS]


**引用藍圖**：[BP-SOLO-HITL-SPEC]


**設計原則**：不加厚治理、但仍Fail-Closed


##### 操作步驟


**Step 1：生成審批請求**
```bash
# 生成 approval.json
cat > staging/approval_pending.json << EOF
{
  "approval_type": "single-file-ack",
  "run_id": "$(date +%Y%m%d_%H%M%S)",
  "action": "EXECUTE",
  "risk_level": "MEDIUM",
  "timestamp": "$(date -Iseconds)",
  "approver_id": "solo_operator",
  "ack_hash": ""
}
EOF
```


**Step 2：人工審核並簽章**
```bash
# 審核後計算hash並簽章
sha256sum staging/approval_pending.json | cut -d' ' -f1 > /tmp/hash.txt
# 將hash填入ack_hash欄位
jq --arg hash "$(cat /tmp/hash.txt)" '.ack_hash = "sha256:\($hash)"' \
  staging/approval_pending.json > staging/approval.json
```


**Step 3：驗證並執行**
```bash
# GateRunner驗證
if [ ! -f "staging/approval.json" ]; then
  echo "ERROR: Missing approval.json"
  exit 1  # BLOCK_RELEASE
fi


# 驗證hash
expected_hash=$(jq -r '.ack_hash' staging/approval.json | cut -d: -f2)
actual_hash=$(jq 'del(.ack_hash)' staging/approval.json | sha256sum | cut -d' ' -f1)
if [ "$expected_hash" != "$actual_hash" ]; then
  echo "ERROR: ack_hash verification failed"
  exit 1  # BLOCK_RELEASE
fi


echo "Approval verified, proceeding..."
```


##### Fail-Closed檢查點


| 檢查點 | 條件 | 動作 |
|--------|------|------|
| approval.json存在 | 不存在 | BLOCK_RELEASE |
| JSON格式正確 | 解析失敗 | BLOCK_RELEASE |
| ack_hash驗證 | 不匹配 | BLOCK_RELEASE |
| risk_level=HIGH | 無HITL_CONFIRM | BLOCK_RELEASE |


##### evidence_ptr


| 產出 | 路徑 |
|------|------|
| 審批檔案 | /evidence/approval/{run_id}/approval.json |
| 驗證日誌 | /evidence/approval/{run_id}/verification_log.txt |






§6.9 MVS最小技能集定義
[ANCHOR:SPLMVP-MVS]


**引用藍圖**：[BP-MVS-SPEC]


### §6.9.1 「不得當裁判」原則


| 角色 | Skills/Cowork | GateKit/GateRunner |
|---|---|---|
| 定位 | 製作工 | 裁判 |
| 職責 | 產成品/整理/組裝 | 判定PASS/FAIL |
| 輸出 | 工件、草稿、格式化文件 | gate_report.json |
| 可稽核性 | 需經Gate驗證 | 直接可稽核 |


⚠️ **Skills/Cowork輸出禁止直接標記PASS/FAIL，必須經GateRunner驗證**


§6.9.2 定案Skills清單


| Skill ID | 版本 | 用途 | 狀態 | Gate綁定 |
|---|---|---|---|---|
| spartoi-schema | v1.0.0 | Schema驗證 | **定案** | G-SCHEMA |


### §6.9.3 CR_OPEN候選Skills清單


| Skill ID | 用途 | Runbook對應 | CR_OPEN狀態 |
|---|---|---|---|
| spartoi-evidencepack-builder | 三件套組裝 | §7.6 | CR_OPEN-019 |
| spartoi-gatekit-runner | Gate執行 | §7.5 | CR_OPEN候選 |
| spartoi-authority-scope-lock | 規範引用檢查 | §2 | CR_OPEN候選 |
| pipeline-a-specpack-guardrails | Pipeline A護欄 | §6.1.1 | CR_OPEN-021 |
| pipeline-b-strategypack-guardrails | Pipeline B護欄 | §6.1.2 | CR_OPEN-021 |
| pipeline-c-xspack-guardrails | Pipeline C護欄 | §6.1.3 | CR_OPEN-021 |
| spartoi-agent-command-acl | 命令ACL檢查 | §6.3.4 | CR_OPEN候選 |
| spartoi-third-party-reviewer-kit | 第三方審查 | §6.4.2 | CR_OPEN候選 |


§6.9.4 Skills驗證流程
新增Skill提議 ↓ 登記CR_OPEN 
↓ 
Skill內容經G-RUN驗證
 ↓ 
驗證通過 → 納入「已驗證Skills清單」 
↓ 
Ops可使用（僅限已驗證Skills）


§6.9.5 Evidence欄位
```json
{
  "skills_used": [
    {
      "skill_id": "spartoi-schema",
      "skill_version": "v1.0.0",
      "trigger_reason": "manifest validation",
      "gate_verification": "PASS"
    }
  ]
}
```


________________


§7 Gate與EvidencePack規範
[ANCHOR:SPLMVP-S7-GATE]
本節DoD：8 Gate模板齊全、GateKit結構明確、EvidencePack三件套定義
§7.1 Gate體系分層
[ANCHOR:SPLMVP-GATE-LAYERING]
引用藍圖：見 [BP-S5-GATEKIT]
分層說明
層級
	位置
	職責
	規劃層（7類）
	藍圖SSOT [BP-7-GATE-CLASSES]
	定義「驗什麼」（概念層）
	實作層（8模板）
	藍圖SSOT [BP-8-GATE-TEMPLATES]
	定義「怎麼驗」（模板規格）
	工程層
	本RUNBOOK §7.5
	定義「如何執行」（落地結構）
	⚠️ One-rule-one-place：Gate分類與模板定義在藍圖SSOT，本RUNBOOK只定義工程落地。
§7.2 7類Gate分類（引用藍圖）
[ANCHOR:SPLMVP-7-GATE-CLASSES]
引用藍圖：見 [BP-7-GATE-CLASSES]
G5分類
	分類名稱
	對應模板Gate
	G5-A
	Build & Repro
	G-RUN
	G5-B
	Spec/Index Integrity
	G-SCHEMA
	G5-C
	Artifact Contract
	G-SRC
	G5-D
	Safety Fail-Closed
	G-HITL-LOG
	G5-E
	LLM Output Quality
	G-SEG-L
	G5-F
	E2E Spine Regression
	G-CONF-L
	G5-G
	Performance & TCA
	G-BT-H
	§7.3 8個固定模板Gate（引用藍圖）
[ANCHOR:SPLMVP-8-GATE-TEMPLATES]
引用藍圖：見 [BP-8-GATE-TEMPLATES]
gate_id
	gate_name
	核心檢查
	fail_action
	G-SRC
	來源完整性Gate
	No-Source-No-Norm、必填欄位、引用鏈可解析
	BLOCK_RELEASE
	G-SCHEMA
	Schema合規Gate
	JSON Schema校驗、additionalProperties:false
	fail-closed
	G-BT-H
	回測健康度Gate
	回測報告存在、口徑一致、防前視/防洩漏
	CONDITIONAL
	G-SEG-L
	語意保真Gate
	Golden set抽樣比對、無關鍵矛盾/遺漏
	fail+drift_log
	G-CONF-L
	覆蓋率/信賴度Gate
	accuracy>40%、最小樣本量
	CONDITIONAL
	G-XQ-PARITY
	XQ一致性Gate
	XS可編譯、signal parity、paper trading
	fail-closed
	G-HITL-LOG
	HITL日誌Gate
	hitl_handoff存在、人工確認紀錄
	BLOCK_RELEASE
	G-RUN
	可執行Gate
	一鍵跑通、環境指紋一致、No-API基線
	fail-closed
	§7.4 Gate模板固定欄位
[ANCHOR:SPLMVP-GATE-TEMPLATE-FIELDS]
每個Gate模板必須包含以下欄位：
# Gate模板固定欄位
gate_id: G-{ID}
gate_name: {Gate名稱}
scope: Spine | 子系統 | 工件類型
inputs:
  - {輸入1}
  - {輸入2}
checks:
  - {子檢查點1}
  - {子檢查點2}
pass_criteria: {最小通過條件}
evidence:
  - {必須輸出的檔案}
  - {落盤位置}
fail_action: BLOCK_RELEASE | RADAR_ONLY | EXECUTE_DISABLED
owner: HITL | Reviewer-LLM | Auto
frequency: 每次變更 | 每日 | 版本發布前
drift_log: {語意/蒸餾差異記錄位置}
judgment_logic: |
  {判定邏輯}
evidence_schema:
  - {schema定義}


§7.5 GateKit工程層落地
[ANCHOR:SPLMVP-GATEKIT-ENG]
§7.5.1 /gates/目錄結構
/gates/
├── schemas/
│   ├── artifact_manifest.schema.json
│   ├── evidence_index.schema.json
│   └── gate_report.schema.json
├── runner/
│   ├── run_gates.ps1
│   ├── run_gates.py
│   └── gate_runner.py
├── templates/
│   ├── G-SRC.template.yaml
│   ├── G-SCHEMA.template.yaml
│   ├── G-BT-H.template.yaml
│   ├── G-SEG-L.template.yaml
│   ├── G-CONF-L.template.yaml
│   ├── G-XQ-PARITY.template.yaml
│   ├── G-HITL-LOG.template.yaml
│   └── G-RUN.template.yaml
├── golden_set/
│   └── {10-30條抽樣集}
├── reports/
│   └── {每次跑完的摘要}
└── commands/
    ├── AGENTS.md
    └── /commands/


§7.5.2 GateRunner最小行為
[ANCHOR:SPLMVP-GATERUNNER]
引用藍圖：見 [BP-GATERUNNER]
讀manifest → 依模板執行最小檢核/抽樣 → 產三件套(manifest + gate_report + artifacts)


GateRunner不做：
* CI/CD平台化
* 全量回測矩陣
* Web UI / 排程中心 / 結果儀表板
* 權限矩陣
* 長週期數據工程
§7.5.3 GateRunner異常處理
[ANCHOR:SPLMVP-GATERUNNER-EXCEPTION]
引用藍圖：見 [BP-GATERUNNER]


Error Code Mapping Table
error_code        異常類型        處理方式        恢復流程        Fail-Closed行為
ERR-GR-001        manifest解析失敗        BLOCK + 記錄error_log        檢查manifest格式 → 修正 → 重跑        阻斷所有下游Gate
ERR-GR-002        Gate模板不存在        BLOCK + 登記CR_OPEN        確認模板路徑 → 補齊模板 → 重跑        阻斷該Gate及其下游
ERR-GR-003        證據檔案缺失        BLOCK + 記錄missing_evidence        檢查evidence_ptr → 補產證據 → 重跑        阻斷該Gate
ERR-GR-004        Schema校驗失敗        fail-closed + 記錄validation_error        檢查Schema定義 → 修正數據 → 重跑        阻斷該Gate
ERR-GR-005        Golden set不足        RADAR_ONLY + 記錄warning        補充golden_set至最小10條 → 重跑        不阻斷但標記風險
ERR-GR-006        執行超時        BLOCK + 記錄timeout_log        檢查資源 → 增加timeout → 重跑        阻斷該Gate
ERR-GR-007        環境指紋不一致        BLOCK + 記錄env_mismatch        重建環境 → 更新fingerprint → 重跑        阻斷G-RUN Gate
ERR-GR-008        權限不足        BLOCK + 記錄permission_denied        檢查ACL → 申請權限 → 重跑        阻斷該Gate
ERR-GR-009        外部依賴失敗        RADAR_ONLY + 記錄dependency_error        檢查網路/服務 → 重試 → 降級        可降級執行
ERR-GR-010        未知錯誤        BLOCK + 記錄unknown_error + 登記CR_OPEN        人工診斷 → 登記CR_OPEN → 裁決        阻斷全流程


Error Log Schema
```json
{
  "error_code": "ERR-GR-001",
  "error_type": "manifest_parse_failure",
  "timestamp": "2026-01-16T10:00:00+08:00",
  "gate_id": "G-SRC",
  "run_id": "run-2026-01-16-001",
  "error_message": "JSON parse error at line 15",
  "stack_trace": "...",
  "recovery_attempted": true,
  "recovery_result": "FAILED",
  "escalation": "CR_OPEN-REF-XXX",
  "evidence_ptr": "/evidence/error/{run_id}/ERR-GR-001.json"
}
```


恢復流程總則
```yaml
recovery_policy:
  max_auto_retry: 3
  retry_interval_sec: 60
  escalation_threshold: 3  # 超過3次自動重試 → 升級至HITL
  
  recovery_steps:
    1. 記錄error_log（含完整stack_trace）
    2. 判斷error_code是否可自動恢復
    3. 若可自動恢復 → 執行恢復流程 → 重跑Gate
    4. 若不可自動恢復 → 升級至HITL或登記CR_OPEN
    5. 恢復後產生 recovery_evidence.json
    
  non_recoverable_errors:
    - ERR-GR-002（模板缺失需人工補齊）
    - ERR-GR-008（權限需人工申請）
    - ERR-GR-010（未知錯誤需人工診斷）
```
§7.6 EvidencePack三件套
[ANCHOR:SPLMVP-EVIDENCE-PACK]
引用藍圖：見 [BP-EVIDENCE-SCHEMA]
每次pipeline/Gate執行必產EvidencePack三件套：
檔案
	說明
	manifest.json
	本次run_id、git sha、輸入資料hash、環境資訊
	gate_report.json
	每個Gate的PASS/FAIL、關鍵數值、evidence_ptr
	artifacts/
	方法卡、分析包、選股清單、xs_script_pack等
	manifest.json Schema
{
  "run_id": "run-2026-01-16-001",
  "git_sha": "abc123",
  "timestamp": "2026-01-16T10:00:00+08:00",
  "pipeline_id": "Pipeline-A",
  "operator": "Claude Code",
  "inputs": [
    {
      "input_id": "ICT_PDF_001",
      "path": "/data/ict_pdf/module_001.pdf",
      "hash": "sha256:xxx"
    }
  ],
  "outputs": [
    {
      "output_id": "SpecPack_001",
      "path": "/artifact/specpack/specpack_001/",
      "hash": "sha256:xxx"
    }
  ],
  "gates": [
    {
      "gate_id": "G-SRC",
      "status": "PASS",
      "evidence_ptr": "/evidence/g-src/report.json"
    }
  ],
  "environment": {
    "backend": "codespaces",
    "python_version": "3.11",
    "node_version": "18"
  }
}


gate_report.json Schema
{
  "run_id": "run-2026-01-16-001",
  "gates": [
    {
      "gate_id": "G-SRC",
      "gate_name": "來源完整性Gate",
      "status": "PASS",
      "checks": [
        {
          "check_id": "no-source-no-norm",
          "status": "PASS",
          "evidence": "/evidence/g-src/source_check.json"
        }
      ],
      "pass_criteria_met": true,
      "fail_action": null,
      "evidence_ptr": "/evidence/g-src/report.json",
      "timestamp": "2026-01-16T10:05:00+08:00"
    }
  ],
  "overall_status": "PASS",
  "blocking_gates": []
}


§7.6.2 Rollback Package規格
[ANCHOR:SPLMVP-ROLLBACK-SPEC]


**引用藍圖**：[BP-ROLLBACK-SPEC]


**Gate分類**：歸類於 G5-F Fail-Safe


#### Evidence Pack擴充結構


原三件套維持不變，artifacts/下新增rollback/子目錄：
evidence_pack/ 
├── manifest.json 
├── gate_report.json 
└── artifacts/ 
├── evidence/ 
├── outputs/ 
└── rollback/ ← 新增
├── pre_snapshot/
│ └── {原始檔案備份}
├── diff_report.json 
└── rollback_script.sh
**注意**：rollback是artifacts的子目錄，**不是第四件套**，不改變三件套結構。


#### diff_report.json Schema
```json
{
  "run_id": "run-xxx",
  "operation_type": "OVERWRITE|DELETE|MOVE|TRANSFORM",
  "files_affected": [
    {
      "file_path": "/path/to/file",
      "action": "MODIFIED|DELETED|CREATED",
      "diff_summary": "brief description",
      "original_hash": "sha256:xxx",
      "new_hash": "sha256:yyy"
    }
  ],
  "rollback_available": true,
  "rollback_tested": false,
  "rollback_script_ptr": "./rollback_script.sh"
}
```


#### Gate掛鉤


| Gate | 檢查項 |
|---|---|
| G-RUN | rollback_script可執行 |
| G-SCHEMA | diff_report符合Schema |
| G-HITL-LOG | destructive操作有核准 |


#### 回滾觸發流程


| 觸發條件 | 執行方式 | 記錄 |
|---|---|---|
| Gate FAIL | 運行rollback_script.sh | rollback_execution_log.json |
| 人工決定 | 手動恢復pre_snapshot | rollback_execution_log.json |
| 異常偵測 | 自動觸發回滾 | rollback_execution_log.json |




§7.7 Replay Contract（可回放契約）
[ANCHOR:SPLMVP-REPLAY-CONTRACT]
引用藍圖：見 [BP-S6-EVIDENCE] §6.2
三級可回放標準
級別
	標準
	最小材料
	L1-Audit
	可追溯
	manifest + gate_report + run_log
	L2-Reproduce
	可重現
	L1 + inputs hash + environment snapshot
	L3-Replay
	可重跑
	L2 + executable artifacts + golden_set
	可回放最小材料清單
replay_materials:
  mandatory:
    - manifest.json
    - gate_report.json
    - run_log.md
  optional_l2:
    - inputs_hash.json
    - environment_snapshot.yaml
  optional_l3:
    - executable_artifacts/
    - golden_set/
    - replay_script.sh


§8 15子系統MVP最小行為
[ANCHOR:SPLMVP-S8-SUBSYS]
本節DoD：每子系統verify_min/stopline/fail_closed_behavior明確
§8.1 15子系統白名單
[ANCHOR:SPLMVP-SUBSYS-WHITELIST]
引用藍圖：見 [BP-SUBSYSTEM-LIST]
#
	子系統ID
	子系統名稱
	Pipeline位置
	1
	CA-WRC
	教材蒐集
	Pipeline A
	2
	CA-CORPUS
	語料庫
	Pipeline A
	3
	CA-DISTILL
	蒸餾
	Pipeline A
	4
	CA-DSL
	原語庫
	Pipeline A
	5
	CA-METHOD
	方法制定
	Pipeline B
	6
	CA-BACKTEST
	回測驗證
	Pipeline B
	7
	CA-TA
	技術分析
	Pipeline C
	8
	CA-SELECT
	選股
	Pipeline C
	9
	CA-TRANSLATE
	XS轉譯
	Pipeline C
	10
	CA-WATCH
	盯盤
	執行層
	11
	CA-EXECUTE
	操盤
	執行層
	12
	CA-PERFORM
	績效分析
	回饋層
	13
	CA-GOVERN
	治理
	Cross-Cutting
	14
	CA-COLLAB
	協作
	Cross-Cutting
	15
	CA-UI
	桌面入口
	Cross-Cutting
	硬規則：不得發明第16個子系統。
§8.2 各子系統MVP最小行為
§8.2.1 CA-WRC 教材蒐集
[ANCHOR:SPLMVP-CA-WRC]
subsystem_id: CA-WRC
subsystem_name: 教材蒐集子系統
scope:
  - 匯入ICT教材PDF
  - 產生input_manifest
non_responsibility:
  - 蒸餾（CA-DISTILL職責）
  - 索引建立（CA-CORPUS職責）
mvp_position: Pipeline A 入口


mvp_min_behavior:
  input: ICT PDF檔案路徑清單
  output: /outputs/input_manifest.json
  verify_min:
    - input_manifest.json存在
    - 每個PDF有對應hash
    - 無重複PDF
  stopline:
    - 若任一PDF無法讀取 → STOP，列出錯誤清單
    - 若hash計算失敗 → STOP，診斷問題


    threshold_note: |
      本子系統無數值閾值，僅做存在性檢查：
      - PDF可讀性：二元判定（可讀/不可讀）
      - hash計算：二元判定（成功/失敗）
      若需數值化，見 CR_OPEN-REF-001


  fail_closed_behavior:
    - 觸發任一stopline → 阻斷進入下游（CA-CORPUS）
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-SRC
  evidence_ptr: /evidence/wrc/{run_id}/input_manifest.json


§8.2.2 CA-CORPUS 語料庫
[ANCHOR:SPLMVP-CA-CORPUS]
subsystem_id: CA-CORPUS
subsystem_name: 語料庫子系統
scope:
  - 建立檢索索引
  - 產生corpus_snapshot
non_responsibility:
  - 教材匯入（CA-WRC職責）
  - 蒸餾（CA-DISTILL職責）
mvp_position: Pipeline A 中段


mvp_min_behavior:
  input: input_manifest.json
  output: /outputs/corpus_snapshot.json
  verify_min:
    - corpus_snapshot.json存在
    - 索引可查詢
    - 覆蓋率100%（所有PDF已索引）
  stopline:
    - 若索引建立失敗 → STOP，診斷問題
    - 若覆蓋率<100% → RADAR_ONLY，標記遺漏

    threshold_note: |
      覆蓋率閾值：100%（硬規則，不可降級）
      索引建立：二元判定（成功/失敗）
      若需調整覆蓋率門檻，見 CR_OPEN-REF-002


  fail_closed_behavior:
    - 觸發STOP類stopline → 阻斷進入下游
    - 觸發RADAR_ONLY → 繼續但標記風險
    - 產生fail_evidence_ptr記錄原因
  gate_binding: G-SRC
  evidence_ptr: /evidence/corpus/{run_id}/corpus_snapshot.json


§8.2.3 CA-DISTILL 蒸餾
[ANCHOR:SPLMVP-CA-DISTILL]
subsystem_id: CA-DISTILL
subsystem_name: 蒸餾子系統
scope:
  - 蒸餾偽代碼+函數
  - 產生distill_bundle
non_responsibility:
  - 索引建立（CA-CORPUS職責）
  - 原語選擇（CA-DSL職責）
mvp_position: Pipeline A 核心


mvp_min_behavior:
  input: corpus_snapshot.json
  output: /outputs/distill_bundle.json
  verify_min:
    - distill_bundle.json存在
    - Golden set抽樣通過（SEG-Lite）
    - 無關鍵矛盾/遺漏
  stopline:
    - 若Golden set抽樣失敗 → STOP，診斷語意偏差
    - 若發現關鍵矛盾 → STOP，人工裁決
    - 若遺漏率>10% → RADAR_ONLY，標記風險

    threshold_note: |
      - Golden set抽樣數量：見 CR_OPEN-003（建議10-30條）
      - 遺漏率門檻：10%（超過則RADAR_ONLY）
      - 關鍵矛盾：零容忍（任一矛盾即STOP）
      具體數值由 CR_OPEN-003 配置

  fail_closed_behavior:
    - 觸發STOP類stopline → 阻斷進入下游
    - 觸發RADAR_ONLY → 繼續但標記風險
    - 產生fail_evidence_ptr + drift_log記錄
  gate_binding: G-SEG-L
  evidence_ptr: /evidence/distill/{run_id}/distill_bundle.json


§8.2.4 CA-DSL 原語庫
[ANCHOR:SPLMVP-CA-DSL]
subsystem_id: CA-DSL
subsystem_name: 原語庫子系統
scope:
  - 選擇候選結構
  - 產生dsl_schema
non_responsibility:
  - 蒸餾（CA-DISTILL職責）
  - 方法制定（CA-METHOD職責）
mvp_position: Pipeline A 出口


mvp_min_behavior:
  input: distill_bundle.json
  output: /outputs/dsl_schema.json
  verify_min:
    - dsl_schema.json存在
    - Schema結構完整（AST/Schema Gate通過）
    - 函數簽名、依賴、I/O、參數槽位存在
  stopline:
    - 若Schema結構不完整 → STOP，補齊結構
    - 若函數簽名缺失 → STOP，補齊簽名

    threshold_note: |
      本子系統無數值閾值，僅做結構完整性檢查：
      - Schema結構：必須包含AST/依賴/I/O/參數槽位
      - 函數簽名：必須存在（二元判定）
      若需數值化驗證，見 CR_OPEN-REF-003

  fail_closed_behavior:
    - 觸發任一stopline → 阻斷進入下游（CA-METHOD）
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-SCHEMA
  evidence_ptr: /evidence/dsl/{run_id}/dsl_schema.json


§8.2.5 CA-METHOD 方法制定
[ANCHOR:SPLMVP-CA-METHOD]
subsystem_id: CA-METHOD
subsystem_name: 方法制定子系統
scope:
  - 定案規則+風險報酬參數
  - 產生method_card
non_responsibility:
  - 原語選擇（CA-DSL職責）
  - 回測執行（CA-BACKTEST職責）
mvp_position: Pipeline B 入口


mvp_min_behavior:
  input: dsl_schema.json + SpecPack
  output: /outputs/method_card.md
  verify_min:
    - method_card.md存在
    - 必填欄位完整（MSC）
    - 輸入/輸出/前置/禁忌/風控/適用盤態
  stopline:
    - 若必填欄位缺失 → STOP，補齊欄位
    - 若規則自相矛盾 → STOP，人工裁決

    threshold_note: |
      本子系統無數值閾值，僅做必填欄位檢查：
      - MSC必填欄位：輸入/輸出/前置/禁忌/風控/適用盤態
      - 規則一致性：零矛盾（二元判定）
      若需風險報酬數值門檻，見 CR_OPEN-REF-004


  fail_closed_behavior:
    - 觸發任一stopline → 阻斷進入下游（CA-BACKTEST）
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-SRC
  evidence_ptr: /evidence/method/{run_id}/method_card.md


§8.2.6 CA-BACKTEST 回測驗證
[ANCHOR:SPLMVP-CA-BACKTEST]
subsystem_id: CA-BACKTEST
subsystem_name: 回測驗證子系統
scope:
  - 執行回測
  - 產生backtest_report
non_responsibility:
  - 方法制定（CA-METHOD職責）
  - 績效分析（CA-PERFORM職責）
mvp_position: Pipeline B 核心


mvp_min_behavior:
  input: method_card.md + market_data
  output: /outputs/backtest_report.json
  verify_min:
    - backtest_report.json存在
    - BT-Repro可重現（資料hash一致）
    - 回測衛生通過（防前視/防洩漏/成本注入）
  stopline:
    - 若BT-Repro不可重現 → STOP，診斷資料/流程污染
    - 若回測衛生失敗 → STOP，修正資料處理
    - 若勝率<40% → RADAR_ONLY，標記風險但不阻斷

    threshold_note: |
      - 回測健康度：見 G-BT-H Gate
      - 勝率門檻：見 CR_OPEN-002（建議口徑：隔日方向正確）
      - 樣本數：見 CR_OPEN-001（建議N_min=30）
      - 防前視/防洩漏：二元判定（通過/失敗）
      具體數值由 CR_OPEN-001/002 配置


  fail_closed_behavior:
    - 觸發STOP類stopline → 阻斷進入下游
    - 觸發RADAR_ONLY → 繼續但標記風險
    - 產生fail_evidence_ptr記錄原因
  gate_binding: G-BT-H
  evidence_ptr: /evidence/backtest/{run_id}/backtest_report.json


§8.2.7 CA-TA 技術分析
[ANCHOR:SPLMVP-CA-TA]
subsystem_id: CA-TA
subsystem_name: 技術分析子系統
scope:
  - 產生日/周分析包
  - 產生故事卡
non_responsibility:
  - 方法制定（CA-METHOD職責）
  - 選股（CA-SELECT職責）
mvp_position: Pipeline C 入口


mvp_min_behavior:
  input: method_card.md + market_data
  output: /outputs/ta_pack.json
  verify_min:
    - ta_pack.json存在
    - 準確度>=40%
    - 最小樣本數達標
  stopline:
    - 若準確度<=40% → RADAR_ONLY，標記風險但不阻斷
    - 若樣本數不足 → STOP，收集更多樣本
    - 若分析結果與方法卡矛盾 → STOP，對齊後重產

    threshold_note: |
      - TA準確度門檻：見 CR_OPEN-006（建議40%）
      - ICT模組覆蓋：見 CR_OPEN-REF-005
      - 計算結果：必須可重現（二元判定）
      具體數值由 CR_OPEN-006 配置

  fail_closed_behavior:
    - 觸發STOP類stopline → 阻斷進入下游
    - 觸發RADAR_ONLY → 繼續但標記風險
    - 產生fail_evidence_ptr記錄原因
  gate_binding: G-CONF-L
  evidence_ptr: /evidence/ta/{run_id}/accuracy_report.json


§8.2.8 CA-SELECT 選股
[ANCHOR:SPLMVP-CA-SELECT]
subsystem_id: CA-SELECT
subsystem_name: 選股子系統
scope:
  - 執行選股規劃
  - 產生候選個股清單
non_responsibility:
  - 技術分析（CA-TA職責）
  - XS轉譯（CA-TRANSLATE職責）
mvp_position: Pipeline C 中段


mvp_min_behavior:
  input: ta_pack.json + 市場資料
  output: /outputs/select_results.json
  verify_min:
    - select_results.json存在
    - Hit@K >= 2/5（前5檔至少2檔符合）
    - Rank correlation正相關
  stopline:
    - 若Hit@K < 2/5 → RADAR_ONLY，標記風險但不阻斷
    - 若Rank correlation負相關 → STOP，診斷選股邏輯
    - 若選股結果與TA結果不一致 → STOP，對齊後重產


    threshold_note: |
      - Hit@K門檻：見 CR_OPEN-005（建議2/5）
      - 選股池大小：無硬性門檻，記錄於evidence
      - 篩選條件：必須可追溯至TA結果
      具體數值由 CR_OPEN-005 配置


  fail_closed_behavior:
    - 觸發STOP類stopline → 阻斷進入下游
    - 觸發RADAR_ONLY → 繼續但標記風險
    - 產生fail_evidence_ptr記錄原因
  gate_binding: G-CONF-L
  evidence_ptr: /evidence/select/{run_id}/hit_report.json


§8.2.9 CA-TRANSLATE XS轉譯
[ANCHOR:SPLMVP-CA-TRANSLATE]
subsystem_id: CA-TRANSLATE
subsystem_name: XS轉譯子系統
scope:
  - 將方法卡/分析包轉譯為XS語法
  - 產生xs_script_pack
  - 執行parity驗證
non_responsibility:
  - 方法制定（CA-METHOD職責）
  - XQ執行（XQ端職責）
mvp_position: Pipeline C 核心


mvp_min_behavior:
  input: method_card.md + ta_pack.json + select_results.json
  output: /outputs/xs_pack.zip
  verify_min:
    - XS可在XQ編譯
    - Signal parity >= 95%
    - capability_profile產出
  stopline:
    - 若XS編譯失敗 → STOP，修正語法後重試
    - 若Signal parity < 95% → STOP，診斷轉譯邏輯
    - 若capability_profile缺失 → STOP，補充能力報告
    - 若降級報告未產出 → STOP，補充降級說明

    threshold_note: |
      - XS編譯：二元判定（成功/失敗）
      - Signal parity門檻：見 CR_OPEN-004（建議95%）
      - 語法合規：XQ編譯器判定
      具體數值由 CR_OPEN-004 配置


  fail_closed_behavior:
    - 觸發任一stopline → 阻斷進入下游（XQ執行）
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-XQ-PARITY
  evidence_ptr: /evidence/translate/{run_id}/parity_report.json


§8.2.10 CA-WATCH 盯盤
[ANCHOR:SPLMVP-CA-WATCH]
subsystem_id: CA-WATCH
subsystem_name: 盯盤子系統
scope:
  - 產生盯盤規則
  - 監控訊號產生
non_responsibility:
  - 下單執行（CA-EXECUTE職責）
  - XS轉譯（CA-TRANSLATE職責）
mvp_position: 執行層（監控）


mvp_min_behavior:
  input: xs_pack.zip + 即時市場資料
  output: /outputs/watch_plan.json
  verify_min:
    - watch_plan.json存在
    - 訊號可產生（測試模擬）
    - 訊號與XS規則一致
  stopline:
    - 若無法產生訊號 → RADAR_ONLY，標記風險但不阻斷
    - 若訊號與XS規則不一致 → STOP，診斷規則執行
    - 若監控延遲過大 → RADAR_ONLY，標記延遲風險

    threshold_note: |
      - 時序硬規則（不可配置）：
        * T0: 13:10禁新倉、13:20強清、13:25-30 ROD-only
        * T1: 次日13:25前平倉
      - WatchScore：無硬性門檻，記錄於evidence
      時序閾值為INV-TIME-001~003，不可調整


  fail_closed_behavior:
    - 觸發STOP類stopline → 阻斷進入下游
    - 觸發RADAR_ONLY → 繼續但標記風險
    - 產生fail_evidence_ptr記錄原因
  gate_binding: G-HITL-LOG
  evidence_ptr: /evidence/watch/{run_id}/signal_report.json


§8.2.11 CA-EXECUTE 操盤
[ANCHOR:SPLMVP-CA-EXECUTE]
subsystem_id: CA-EXECUTE
subsystem_name: 操盤子系統
scope:
  - 產生下單建議
  - 維護HITL handoff紀錄
  - 禁止unattended下單
non_responsibility:
  - 實際下單（XQ端職責）
  - 盯盤（CA-WATCH職責）
mvp_position: 執行層（HITL必須）


mvp_min_behavior:
  input: watch_plan.json + 訊號
  output: /outputs/hitl_handoff.json
  verify_min:
    - hitl_handoff.json存在
    - 人工確認紀錄存在
    - 時間戳可追溯
  stopline:
    - 若無HITL紀錄 → STOP，禁止任何下單動作
    - 若企圖unattended下單 → STOP，立即阻斷
    - 若handoff時間戳無法追溯 → STOP，補充時間戳
    - 若人工確認未完成 → STOP，等待確認

    threshold_note: |
      - HITL確認：必須存在（零容忍）
      - 時序硬規則：同CA-WATCH（INV-TIME-001~003）
      - 下單執行：僅XQ執行，本地不下單
      HITL為安全停止線，不可配置降級


  fail_closed_behavior:
    - 觸發任一stopline → 阻斷進入下游（XQ執行）
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-HITL-LOG
  evidence_ptr: /evidence/execute/{run_id}/hitl_log.json


§8.2.12 CA-PERFORM 績效分析
[ANCHOR:SPLMVP-CA-PERFORM]
subsystem_id: CA-PERFORM
subsystem_name: 績效分析子系統
scope:
  - 產生績效報告
  - 提出方法升級建議
non_responsibility:
  - 方法制定（CA-METHOD職責）
  - 回測執行（CA-BACKTEST職責）
mvp_position: 回饋層


mvp_min_behavior:
  input: 交易紀錄 + method_card.md
  output: /outputs/perf_summary.json
  verify_min:
    - perf_summary.json存在
    - 報告含Top-3改動建議
    - 每條建議有對應驗證方式
  stopline:
    - 若報告缺少Top-3建議 → RADAR_ONLY，標記品質風險
    - 若建議無法追溯到績效數據 → STOP，補充數據引用
    - 若建議與方法卡矛盾 → STOP，進入HITL裁決

    threshold_note: |
      - 績效計算：必須可追溯至XQ匯出數據
      - 勝率/報酬：記錄於evidence，不做硬性阻斷
      - 回饋提案：必須包含method_card_version_ref
      績效數值為觀測指標，不作為stopline閾值


  fail_closed_behavior:
    - 觸發STOP類stopline → 阻斷進入下游（回饋閉環）
    - 觸發RADAR_ONLY → 繼續但標記風險
    - 產生fail_evidence_ptr記錄原因
  gate_binding: PERFORM-Gate
  evidence_ptr: /evidence/perform/{run_id}/perf_report.json


§8.2.13 CA-GOVERN 治理
[ANCHOR:SPLMVP-CA-GOVERN]
subsystem_id: CA-GOVERN
subsystem_name: 治理子系統
scope:
  - 最小編排器功能
  - run_id產生與追溯
  - 證據包管理
non_responsibility:
  - 各子系統執行
  - 版本控制（Git職責）
mvp_position: Cross-Cutting治理


mvp_min_behavior:
  input: 各子系統產出
  output: /outputs/gov_evidence_pack.zip
  verify_min:
    - 每次Run生成run_id資料夾
    - run_id可追溯
    - 全部產物與摘要索引存在
  stopline:
    - 若run_id不可追溯 → STOP，補充追溯鏈
    - 若索引缺失 → STOP，重建索引
    - 若證據包不完整 → STOP，補齊證據

    threshold_note: |
      本子系統無數值閾值，僅做一致性檢查：
      - SSOT索引：必須可解析（二元判定）
      - Schema合規：見 G-SCHEMA Gate
      - 版本號：必須遵循SemVer（二元判定）


  fail_closed_behavior:
    - 觸發任一stopline → 阻斷MVP交付
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-RUN
  evidence_ptr: /evidence/govern/{run_id}/ssot_index.json


§8.2.14 CA-COLLAB 協作
[ANCHOR:SPLMVP-CA-COLLAB]
subsystem_id: CA-COLLAB
subsystem_name: 協作子系統
scope:
  - 匯出/匯入封包
  - 多人協作交接
non_responsibility:
  - 各子系統執行
  - 治理（CA-GOVERN職責）
mvp_position: Cross-Cutting協作


mvp_min_behavior:
  input: 各子系統Pack
  output: /outputs/export_bundle.zip
  verify_min:
    - export_bundle.zip存在
    - manifest完整
    - hash驗證通過
  stopline:
    - 若manifest缺失 → STOP，補充manifest
    - 若hash驗證失敗 → STOP，重新打包
    - 若匯入後無法解析 → STOP，診斷格式問題

    threshold_note: |
      本子系統無數值閾值，僅做完整性檢查：
      - Export bundle：必須包含完整三件套
      - Hash一致性：二元判定（一致/不一致）
      - 匯入驗證：必須通過G-SCHEMA Gate


  fail_closed_behavior:
    - 觸發任一stopline → 阻斷交接
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-SRC
  evidence_ptr: /evidence/collab/{run_id}/bundle_check.json


§8.2.15 CA-UI 桌面入口
[ANCHOR:SPLMVP-CA-UI]
subsystem_id: CA-UI
subsystem_name: 桌面入口子系統
scope:
  - 提供單一操作入口
  - 連接全部子系統
  - 執行E2E閉環
non_responsibility:
  - 各子系統內部邏輯
  - XQ端操作
mvp_position: Cross-Cutting入口


mvp_min_behavior:
  input: 全部子系統接口
  output: ui_app_ready
  verify_min:
    - E2E smoke從UI點一次能跑完最小閉環
    - 每步都能看到evidence
    - 產物落盤+索引
  stopline:
    - 若smoke失敗 → STOP，診斷閉環斷點
    - 若產物無法索引 → STOP，修復索引功能
    - 若evidence無法顯示 → STOP，修復UI綁定

    threshold_note: |
      本子系統無數值閾值，僅做E2E可執行性檢查：
      - E2E smoke：必須通過（二元判定）
      - UI啟動：必須可啟動（二元判定）
      - 環境指紋：見 G-RUN Gate


  fail_closed_behavior:
    - 觸發任一stopline → 阻斷MVP交付
    - 必須修復問題並重新驗證verify_min
    - 產生fail_evidence_ptr記錄停止原因
  gate_binding: G-RUN
  evidence_ptr: /evidence/ui/{run_id}/e2e_smoke.json


ui_launch_status:
  fields:
    - launch_timestamp
    - subsystems_connected: [CA-WRC, CA-CORPUS, ...]
    - e2e_smoke_result: PASS/FAIL
    - evidence_visible: true/false


________________


§9 Failure Modes（風險與最小防線）
[ANCHOR:SPLMVP-S9-RISK]
本節DoD：Top 10風險已識別、每個風險有<=2句防線、可落地到WI或Gate
§9.1 Top 10執行風險與最小防線
風險ID
	風險描述
	最小防線
	落地點
	RISK-001
	L1失控膨脹成"15個小完整版"
	Runbook硬上限（每子系統SS_README<=2頁）+ Tripwire（超出則裁剪回退）
	§4 Runbook
	RISK-002
	開發用Agent混成上線後產品功能
	§6.3/§6.4嚴格分節 + 用途標籤（DEV/OPS）
	§6
	RISK-003
	GateRunner變成平台
	GateRunner只做「讀manifest→執行→產三件套」
	§7.5.2
	RISK-004
	Evidence不可重演
	run_id + 三件套（manifest/gate_report/run_log）缺一不可
	§7.6
	RISK-005
	回歸=全量回測
	golden_set抽樣 + drift記錄，全量留P2/P2.5
	§7.3
	RISK-006
	WP規格飄移
	Front-Matter模板強制 + 週期檢查
	§5.2.3
	RISK-007
	XQ連接性未驗證就進Mini Core
	Phase-1為關鍵里程碑，未通過禁止進入Phase-2
	§4.2
	RISK-008
	HITL被繞過
	CA-EXECUTE stopline：無HITL紀錄 → BLOCK
	§8.2.11
	RISK-009
	子系統stopline缺失
	每子系統必含stopline + fail_closed_behavior
	§8.2
	RISK-010
	T0/T1混淆
	Route Block明確標註 + 證據分別產生
	§5.2.4
	§9.2 3個雷防線（引用藍圖）
[ANCHOR:SPLMVP-3-PITFALLS]
引用藍圖：見 [BP-S11-COVERAGE] §11.2
#
	雷
	說明
	防線
	1
	把回歸=全量回測
	MVP不是要最佳化全策略空間
	只做golden_set抽樣+drift記錄
	2
	把GateRunner做成平台
	一旦開始做Web UI/排程中心/儀表板，就在寫第二個產品
	GateRunner只做「讀manifest→執行→產三件套」
	3
	Evidence不可重演
	驗收官模式的前提是evidence/log/diff具備可稽核性
	必須有run_id可追溯，三件套缺一不可
	________________


§10 CR_OPEN Register
[ANCHOR:SPLMVP-S10-CR-OPEN]
本節DoD：Candidate→CR_OPEN遷移規則明確、待決項目有預設值、Fail-Closed Default明確
##### CR_OPEN狀態對齊（引用藍圖SSOT v1.2.2）
[ANCHOR:SPLMVP-CR-OPEN-SYNC-V140]


**對齊藍圖SSOT [BP-CR-OPEN-REGISTER-V121] 狀態**：


| cr_id | 狀態 | evidence_refs | notes |
|-------|------|---------------|-------|
| CR_OPEN-015 | TEMP_CLOSED_FOR_MVP_TEST | WE-003,WE-011,WE-012,WE-013; WE-002=UNVERIFIED不可支撐normative | **PRIORITY**; Cowork/Skills效率增益量化 |
| CR_OPEN-019 | TEMP_CLOSED_FOR_MVP_TEST | - | spartoi-evidencepack-builder |
| CR_OPEN-021 | TEMP_CLOSED_FOR_MVP_TEST | WE-006 | Pipeline Skills (a/b/c) |
| CR_OPEN-023 | TEMP_CLOSED_FOR_MVP_TEST | - | skills_used Schema |
| CR_OPEN-024 | **OPEN** | WE-003,WE-015 | **Ops Cowork仍禁用**；預設視為事故 |


**狀態機對齊規則**（引用藍圖 [BP-STATUS-MACHINE]）：
| 狀態 | 必填欄位 | mvp_test值 |
|------|----------|------------|
| OPEN | - | NOT_IN_TEST |
| TEMP_CLOSED_FOR_MVP_TEST | stopline_trigger, rollback_ptr | IN_MVP_TEST |


**一致性維護**：Runbook CR狀態必須與藍圖SSOT保持一致，若發現不一致以藍圖為準。


§10.1 遷移規則
Candidate → CR_OPEN 遷移條件
1. 衝突無法在Authority Stack中裁決
2. 數值門檻需要使用者決定
3. 討論紀錄未明確定義的配置項
4. 藍圖錨點不存在或引用失敗
CR_OPEN 處置方式
處置
	說明
	ACCEPT
	採用預設值
	CONFIGURE
	使用者自訂
	DEFER
	延後至P2/P2.5
	REJECT
	拒絕，採用替代方案
	Fail-Closed Default
等級
	行為
	BLOCK_RELEASE
	阻斷發布，不得進入下游
	RADAR_ONLY
	記錄但不阻斷，標記風險
	§10.2 CR_OPEN Ledger
[ANCHOR:SPLMVP-CR-OPEN-LEDGER]
引用藍圖格式：見 [BP-CR-OPEN-REGISTER]


# CR_OPEN Schema（與藍圖統一）
cr_open_schema:
  required_fields:
    - cr_id
    - category
    - title
    - description
    - default_value
    - user_configurable
    - disposition
    - fail_closed_default
    - evidence_ref
    - created_at
    - updated_at
    - status


CR_OPEN Ledger（完整展開）
cr_id        category        title        description        default_value        user_configurable        disposition        fail_closed_default        evidence_ref        status
CR_OPEN-001        THRESHOLD        N_min（最小樣本數）        統計門檻的最小樣本量，用於G-CONF-L Gate        30        YES        CONFIGURE        RADAR_ONLY        /evidence/cr_open/CR_OPEN-001.json        OPEN
CR_OPEN-002        THRESHOLD        勝率門檻具體口徑        accuracy/precision/hit-rate的定義方式        隔日方向正確        YES        CONFIGURE        RADAR_ONLY        /evidence/cr_open/CR_OPEN-002.json        OPEN
CR_OPEN-003        THRESHOLD        Golden set抽樣數量        蒸餾/語意比對的抽樣集大小，用於G-SEG-L Gate        10-30        YES        CONFIGURE        RADAR_ONLY        /evidence/cr_open/CR_OPEN-003.json        OPEN
CR_OPEN-004        THRESHOLD        Signal parity門檻        XS轉譯parity最低要求，用於G-XQ-PARITY Gate        95%        YES        CONFIGURE        RADAR_ONLY        /evidence/cr_open/CR_OPEN-004.json        OPEN
CR_OPEN-005        THRESHOLD        Hit@K門檻        選股Hit@K最低要求，用於G-CONF-L Gate        2/5        YES        CONFIGURE        RADAR_ONLY        /evidence/cr_open/CR_OPEN-005.json        OPEN
CR_OPEN-006        THRESHOLD        TA準確度門檻        技術分析準確度最低要求，用於G-CONF-L Gate        40%        YES        CONFIGURE        RADAR_ONLY        /evidence/cr_open/CR_OPEN-006.json        OPEN


CR_OPEN Reference Index（新增）
cr_ref_id        referenced_by        purpose
CR_OPEN-REF-001        §8.2.1 CA-WRC threshold_note        WRC數值化閾值引用
CR_OPEN-REF-002        §8.2.2 CA-CORPUS threshold_note        CORPUS覆蓋率門檻引用
CR_OPEN-REF-003        §8.2.4 CA-DSL threshold_note        DSL數值化驗證引用
CR_OPEN-REF-004        §8.2.5 CA-METHOD threshold_note        METHOD風險報酬門檻引用
CR_OPEN-REF-005        §8.2.7 CA-TA threshold_note        TA ICT模組覆蓋引用

### CR_OPEN新增項（v1.2.1對齊）


| CR_OPEN_ID | 內容 | 來源 | 狀態 | 關閉條件 |
|---|---|---|---|---|
| CR_OPEN-018 | Cowork Audit Log整合 | BP-V121 | OPEN | Anthropic提供Compliance API |
| CR_OPEN-019 | TEMP_CLOSED_FOR_MVP_TEST | 同步 | spartoi-evidencepack-builder |
| CR_OPEN-020 | 白名單域名具體清單 | BP-V121 | OPEN | 安全審計完成 |
| CR_OPEN-021 | TEMP_CLOSED_FOR_MVP_TEST | 同步 | Pipeline Skills (a/b/c) |
| CR_OPEN-022 | API Exception Gate | BP-V121 | OPEN | No-API例外審批流程定義 |
| CR_OPEN-023 | TEMP_CLOSED_FOR_MVP_TEST | 同步 | skills_used Schema |
| CR_OPEN-024 | OPEN | 同步 | Ops Cowork仍禁用 |


CR_OPEN 處置流程（與藍圖一致）
處置        說明        適用場景
ACCEPT        採用預設值        預設值已驗證可行
CONFIGURE        使用者自訂        需依場景調整
DEFER        延後至P2/P2.5        MVP階段不處理
REJECT        拒絕，採用替代方案        預設值不適用


§10.3 Missing Ledger（操作層待決）
missing_id
	主題
	原因
	影響面
	建議補強位置
	最小驗證計畫
	Fail-Closed Default
	MISSING-001
	-
	-
	-
	-
	-
	-
	（目前無MISSING項目）
附錄
________________


附錄A：8 Gate模板詳細規格
[ANCHOR:SPLMVP-APPX-A]
G-SRC 來源完整性Gate
gate_id: G-SRC
gate_name: 來源完整性Gate
scope: 全部子系統
inputs:
  - 任何宣稱為規範的文件
checks:
  - No-Source-No-Norm：無evidence_ptr的規範句不得生效
  - 必填欄位存在
  - 引用鏈可解析
pass_criteria: 全部checks通過
evidence:
  - source_check.json
  - /evidence/g-src/{run_id}/
fail_action: BLOCK_RELEASE
owner: Auto
frequency: 每次變更
judgment_logic: |
  1. 解析文件中的[SRC:xxx]引用
  2. 驗證引用目標存在
  3. 驗證必填欄位（inputs/outputs/verify等）
  4. 若任一引用不可解析 → FAIL
evidence_schema:
  - source_refs: [{ref_id, target_path, status}]
  - missing_fields: []
  - result: PASS/FAIL


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


G-SCHEMA Schema合規Gate
gate_id: G-SCHEMA
gate_name: Schema合規Gate
scope: JSON/YAML產物
inputs:
  - 待驗證的JSON/YAML檔案
  - 對應的schema定義
checks:
  - JSON Schema校驗
  - additionalProperties: false
  - 必填欄位存在
pass_criteria: 全部checks通過
evidence:
  - schema_validation.json
  - /evidence/g-schema/{run_id}/
fail_action: fail-closed
owner: Auto
frequency: 每次變更
judgment_logic: |
  1. 載入schema定義
  2. 執行JSON Schema校驗
  3. 檢查additionalProperties約束
  4. 若任一校驗失敗 → FAIL
evidence_schema:
  - schema_path: string
  - validation_errors: []
  - result: PASS/FAIL


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


G-BT-H 回測健康度Gate
gate_id: G-BT-H
gate_name: 回測健康度Gate
scope: CA-BACKTEST
inputs:
  - backtest_report.json
  - method_card.md
  - market_data_hash
checks:
  - 回測報告存在
  - 口徑一致（method_card參數對應）
  - 防前視（無未來資料）
  - 防洩漏（訓練/測試分離）
  - 成本注入存在
pass_criteria: 全部checks通過，BT-Repro可重現
evidence:
  - backtest_hygiene.json
  - /evidence/g-bt-h/{run_id}/
fail_action: CONDITIONAL（勝率<40% → RADAR_ONLY）
owner: HITL
frequency: 每次方法變更
judgment_logic: |
  1. 驗證backtest_report存在
  2. 比對method_card參數
  3. 檢查時間戳對齊
  4. 若發現前視資料 → FAIL
  5. 若勝率<40% → RADAR_ONLY
evidence_schema:
  - report_exists: boolean
  - param_match: boolean
  - no_lookahead: boolean
  - cost_injected: boolean
  - result: PASS/FAIL/RADAR_ONLY


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


G-SEG-L 語意保真Gate
gate_id: G-SEG-L
gate_name: 語意保真Gate
scope: CA-DISTILL
inputs:
  - distill_bundle.json
  - golden_set/（10-30條）
checks:
  - Golden set抽樣比對
  - 無關鍵矛盾
  - 無遺漏
pass_criteria: Golden set通過率>=90%
evidence:
  - semantic_check.json
  - drift_log.json
  - /evidence/g-seg-l/{run_id}/
fail_action: fail + drift_log
owner: HITL
frequency: 每次蒸餾
judgment_logic: |
  1. 載入golden_set
  2. 對每條golden進行比對
  3. 計算通過率
  4. 若通過率<90% → FAIL
  5. 記錄drift_log
evidence_schema:
  - golden_set_size: integer
  - pass_count: integer
  - pass_rate: float
  - contradictions: []
  - omissions: []
  - result: PASS/FAIL


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


G-CONF-L 覆蓋率/信賴度Gate
gate_id: G-CONF-L
gate_name: 覆蓋率/信賴度Gate
scope: CA-TA, CA-SELECT
inputs:
  - accuracy_report.json
  - sample_size
checks:
  - accuracy >= 40%
  - 最小樣本量達標（N_min）
pass_criteria: accuracy>=40% AND sample_size>=N_min
evidence:
  - confidence_report.json
  - /evidence/g-conf-l/{run_id}/
fail_action: CONDITIONAL（未達標 → RADAR_ONLY）
owner: Auto
frequency: 每次分析
judgment_logic: |
  1. 計算accuracy
  2. 計算信賴區間
  3. 檢查樣本量>=N_min
  4. 若accuracy<40% → RADAR_ONLY
  5. 若樣本量不足 → STOP
evidence_schema:
  - accuracy: float
  - confidence_interval: [lower, upper]
  - sample_size: integer
  - n_min: integer
  - result: PASS/FAIL/RADAR_ONLY


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


## 附錄M：Cowork/Skills風險防線
[ANCHOR:SPLMVP-APPX-M-RISK]


**引用藍圖**：[BP-RISK-DEFENSE-V121]


### M.1 Top 10風險與防線


| 風險# | 風險描述 | 級別 | 最小防線 | Runbook落點 |
|---|---|---|---|---|
| RISK-001 | Prompt Injection | CRITICAL | L3拒收+Sanitizer+白名單 | §6.6 |
| RISK-002 | 資料外洩 | CRITICAL | API上傳偵測+白名單 | §1.5(REF) |
| RISK-003 | 誤覆寫SSOT | HIGH | Staging-only+兩段式+HITL | §6.7, §6.8 |
| RISK-004 | Cowork當裁判 | HIGH | 不得當裁判原則+Gate強制 | §6.9 |
| RISK-005 | Ops誤啟用Cowork | HIGH | 預設禁用+BLOCK_RELEASE | §6.4.4 |
| RISK-006 | 模板膨脹 | MED | 固定8/7+Tripwire | §7(REF) |
| RISK-007 | 雙憲法 | MED | One-rule-one-place | §2, 附錄E |
| RISK-008 | 白名單繞過 | MED | allowlist強制 | CR_OPEN-020 |
| RISK-009 | 不可回滾 | MED | Rollback Package強制 | §7.6 |
| RISK-010 | Evidence缺口 | MED | skills_used強制 | manifest |


### M.2 Tripwires清單


| TW_ID | 偵測目標 | 偵測方式 | 違反處置 |
|---|---|---|---|
| TW-008 | Cowork平台化 | grep「Cowork.*取代」 | 修改措辭 |
| TW-009 | Skills規範越界 | grep「Skills輸出.*Normative」 | 補Gate驗證 |
| TW-010 | 操作細節回塞 | grep「cowork.*步驟」 | Route-Out |
| TW-011 | UNVERIFIED偷渡 | grep「UNVERIFIED」無CR_OPEN | 補CR_OPEN-ID |
| TW-012 | Web入規範 | Web-Delta引用到Normative | 補CR_OPEN |


## 附錄N：Web Delta（Non-normative）
[ANCHOR:SPLMVP-APPX-N-WEB]


⚠️ **本附錄為Non-normative，不作PASS/FAIL依據。若要入規範需走CR_OPEN機制。**


### N.1 2026-01-17 Web資訊快照


| 項目 | 內容 | 來源 |
|---|---|---|
| Cowork發布 | 2026-01-12 Research Preview | Anthropic官網 |
| Cowork訂閱 | Pro($20/月)或Max($100-200/月)，2026-01-16擴展Pro | Web |
| Skills API | Beta版本 skills-2025-10-02 | Anthropic Docs |
| 已知漏洞 | Files API exfiltration (PromptArmor) | 安全研究報告 |


### N.2 入規範需求


若上述任何資訊需納入Normative章節，必須：
1. 登記CR_OPEN
2. 經人工驗證
3. 關閉CR_OPEN後方可引用


## 附錄O：研究報告要點決策表
[ANCHOR:SPLMVP-APPX-O-RESEARCH]


### O.1 決策統計


| 報告 | 總項數 | 採納 | Non-normative | CR_OPEN | 不採納 |
|---|---|---|---|---|---|
| REPORT-A | 19 | 11 | 3 | 4 | 1 |
| REPORT-B | 15 | 8 | 4 | 3 | 0 |
| REPORT-C | 14 | 7 | 2 | 4 | 1 |
| REPORT-D | 25 | 17 | 0 | 8 | 0 |
| **合計** | **73** | **43** | **9** | **19** | **2** |


### O.2 關鍵決策摘要


| 決策類型 | 代表項目 | 理由 |
|---|---|---|
| 採納 | Skills封裝流程、Cowork Dev限定、HITL強制 | 符合藍圖v1.2.1 |
| Non-normative | 效率增益數值、Token消耗數值 | UNVERIFIED需CR_OPEN-015 |
| CR_OPEN | 三階段導入、Skills Pack完整清單 | 待藍圖CR_OPEN關閉 |
| 不採納 | 85%效率、70-85% Token節省 | UNVERIFIED+未驗證 |


完整決策表見升級方案§3.2 M-2矩陣。


G-XQ-PARITY XQ一致性Gate
gate_id: G-XQ-PARITY
gate_name: XQ一致性Gate
scope: CA-TRANSLATE
inputs:
  - xs_script.txt
  - python_reference_signals
  - XQ環境
checks:
  - XS可編譯
  - Signal parity >= 95%
  - capability_profile存在
pass_criteria: 編譯通過 AND parity>=95%
evidence:
  - parity_report.json
  - capability_profile.json
  - /evidence/g-xq-parity/{run_id}/
fail_action: fail-closed
owner: HITL
frequency: 每次轉譯
judgment_logic: |
  1. 編譯XS語法
  2. 若編譯失敗 → FAIL
  3. 執行signal比對
  4. 若parity<95% → FAIL
  5. 產生capability_profile
evidence_schema:
  - compile_status: PASS/FAIL
  - signal_parity: float
  - capability_profile: object
  - degradation_report: object
  - result: PASS/FAIL


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


G-HITL-LOG HITL日誌Gate
gate_id: G-HITL-LOG
gate_name: HITL日誌Gate
scope: CA-WATCH, CA-EXECUTE
inputs:
  - hitl_handoff.json
checks:
  - hitl_handoff存在
  - 人工確認紀錄存在
  - 時間戳可追溯
pass_criteria: 全部checks通過
evidence:
  - hitl_log.json
  - /evidence/g-hitl-log/{run_id}/
fail_action: BLOCK_RELEASE
owner: HITL
frequency: 每次執行
judgment_logic: |
  1. 檢查hitl_handoff.json存在
  2. 檢查human_confirmation欄位
  3. 檢查timestamp可追溯
  4. 若任一缺失 → BLOCK
evidence_schema:
  - handoff_exists: boolean
  - confirmation_exists: boolean
  - timestamp_traceable: boolean
  - result: PASS/FAIL


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


G-RUN 可執行Gate
gate_id: G-RUN
gate_name: 可執行Gate
scope: MVP Spine, CA-UI, CA-GOVERN
inputs:
  - 執行環境
  - 待執行腳本/程式
checks:
  - 一鍵跑通
  - 環境指紋一致
  - No-API基線（無外部API依賴時可離線跑）
pass_criteria: 全部checks通過
evidence:
  - run_log.json
  - environment_fingerprint.json
  - /evidence/g-run/{run_id}/
fail_action: fail-closed
owner: Auto
frequency: 每次發布
judgment_logic: |
  1. 執行一鍵跑通測試
  2. 若執行失敗 → FAIL
  3. 比對環境指紋
  4. 若指紋不一致 → FAIL
evidence_schema:
  - run_status: PASS/FAIL
  - exit_code: integer
  - environment_match: boolean
  - result: PASS/FAIL


drift_log:
  enabled: true | false          # 是否啟用drift記錄
  log_path: /evidence/{gate_id}/{run_id}/drift_log.json
  trigger_conditions:
    - 語意比對分數變化 > 5%
    - 覆蓋率變化 > 10%
    - 新增/移除關鍵欄位
  log_schema:
    drift_id: DRIFT-{gate_id}-{seq}
    detected_at: YYYY-MM-DDTHH:MM:SSZ
    drift_type: SEMANTIC | SCHEMA | COVERAGE | THRESHOLD
    baseline_value: {基線值}
    current_value: {當前值}
    delta: {差異}
    severity: LOW | MED | HIGH
    resolution: ACCEPT | REJECT | CR_OPEN
    evidence_ptr: /evidence/drift/{drift_id}.json


________________


附錄B：WI操作卡集
[ANCHOR:SPLMVP-APPX-B]
關鍵WI卡清單（12張）
WI ID
	名稱
	所屬Stage
	狀態
	WI-PREFLIGHT-AUTHORITY-001
	建立Authority Stack引用表
	Phase-0
	ACTIVE
	WI-PREFLIGHT-SCOPELOCK-001
	建立Scope-Lock配置
	Phase-0
	ACTIVE
	WI-SPINE-SCAFFOLD-001
	建立Spine v0目錄骨架
	Phase-1
	ACTIVE
	WI-XQ-CONNECTIVITY-SPIKE-001
	XQ/XS v0連接性驗證
	Phase-1
	ACTIVE
	WI-MC4-BUILD-001
	建立子系統Mini Core Four
	Phase-2
	ACTIVE
	WI-WP-BUILD-001
	建立子系統WP
	Phase-3
	ACTIVE
	WI-GATEKIT-BUILD-001
	建立GateKit
	Phase-4
	ACTIVE
	WI-GATERUNNER-BUILD-001
	建立GateRunner
	Phase-4
	ACTIVE
	WI-SPINE-V1-COLLECT-001
	收斂15子系統至Spine v1
	Phase-5
	ACTIVE
	WI-SPINE-V1-ACCEPT-001
	產生acceptance_status
	Phase-5
	ACTIVE
	WI-EVIDENCE-PACK-001
	產生EvidencePack三件套
	每Phase
	ACTIVE
	WI-MANIFEST-GEN-001
	產生Manifest
	每Pipeline
	ACTIVE
	ADR參考：見 §5.5 ADR-RB-001 WI卡數量縮減說明

### WI-CSP-AGENT-CLOSED-LOOP（v1.4.0新增）
[ANCHOR:SPLMVP-WI-CSP-CLOSED-LOOP]


整合自 Codespaces Upgrade v1.1.0（2026-01-21）


| 欄位 | 值 |
|------|-----|
| WI ID | WI-CSP-AGENT-CLOSED-LOOP |
| 名稱 | 閉環執行卡（Codespaces Agent Closed-Loop） |
| 所屬Stage | 每Phase |
| 狀態 | ACTIVE |
| 前置條件 | Job Spec 存在、Skills Catalog 就緒 |
| 執行命令 | `./scripts/entrypoint.sh --job-spec jobs/dev.job.yaml --profile dev` |
| 必產工件 | verdict.json, evidence triad (manifest.json, gate_report.json, evidence_index.json) |
| 驗收標準 | exit code = 0 且 verdict.json.overall = PASS |
| rollback | 若失敗 → 檢查 gate_report → 修復 → 重跑 |


**5步驟流程**：
1. **Preflight**：驗證 job_spec schema，exit 1 if fail
2. **Skills Dispatch**：依 skills[] 執行，exit 2 if skill fail
3. **Evidence Collect**：產出 evidence triad，exit 4 if missing
4. **Gate Run**：執行 gate checks，exit 3 if gate fail
5. **Verdict Stage**：產出 verdict.json


### SPLMVP-VERDICT-STAGE（v1.4.0新增）
[ANCHOR:SPLMVP-VERDICT-STAGE]


整合自 Codespaces Upgrade v1.1.0（2026-01-21）


**Verdict Stage 實作規格**：
| 欄位 | 值 |
|------|-----|
| 腳本路徑 | scripts/verdict_stage.sh |
| 輸入 | gate_report.json, evidence_index.json |
| 輸出 | verdict.json |
| 硬規則 | verdict.json MUST 由此腳本產出，AI MUST NOT 產生 |


**Exit Codes**：
| Code | 語義 |
|------|------|
| 0 | SUCCESS |
| 1 | FAIL |
| 4 | EVIDENCE_MISSING |


**兩層驗收硬規則**：
- Layer-1 verdict.json is authoritative
- Layer-2 AI summary MUST NOT change status
- If ai_summary.status != verdict.status → runner FAIL


### SPLMVP-JOBSPEC-TEMPLATE（v1.4.0新增）
[ANCHOR:SPLMVP-JOBSPEC-TEMPLATE]


整合自 Codespaces Upgrade v1.1.0（2026-01-21）


**Job Spec 完整範例**：
```yaml
# jobs/dev.job.yaml
job_id: "DEV-001"
profile: "dev"                          # dev | ops
run_id: "{auto_generated_uuid}"
input:
  snapshot_hash: "{sha256}"             # MUST exist
skills:
  - sp-preflight
  - sp-phase1-pre
  - sp-phase1-post
  - sp-gate-run
gates:
  required:
    - gate-src
    - gate-schema
    - gate-run
    - gate-evid
    - gate-denylist
stopline:
  max_iterations: 3
  max_minutes: 30
  max_changed_files: 50
output:
  evidence_dir: "evidence/{run_id}/"
  verdict_path: "out/verdict.json"


Stopline 規則：
條件
	門檻
	觸發後行為
	max_iterations
	3
	FAIL/BLOCKED + HITL_REQUEST.json
	max_minutes
	30
	FAIL/BLOCKED + HITL_REQUEST.json
	max_changed_files
	50
	FAIL/BLOCKED + HITL_REQUEST.json
	

________________


附錄C：Manifest/Schema/Checklists
[ANCHOR:SPLMVP-APPX-C]


## JobSpec 最小模板（jobs/*.job.yaml）
[ANCHOR:SPLMVP-JOBSPEC-MIN-v140]
> 目的：把 “規範→可執行入口” 釘死；新 AI 只要填值就能跑，不必自己發明 schema。
> 原則：缺欄位＝Fail-Closed；不得由 LLM 自行補洞。
```yaml
job:
  job_id: "DEV-LOCAL-001"
  run_id: "20260121T120000Z_ab12cd"          # 必須唯一
  mode: dev                                  # dev | ops
  execution_backend: codespaces              # codespaces | local-manual
  runner: orchestrator                       # orchestrator | minimpl
  pipeline: "C"                              # A | B-Strategy | B-Learn | C
  phase: "Phase-0"                           # Phase-0..Phase-5
  entrypoint:
    command: "./scripts/entrypoint.sh"       # Orchestrator；若 runner=minimpl，command 改為 MinImpl entrypoint
    args: ["--job-spec", "jobs/dev.job.yaml"]
policies:
  fail_closed: true
  ops_cowork_used: false                     # ops 必須 false；違反→BLOCK_RELEASE
inputs:
  manifest_inputs:
    - path: "inputs/placeholder.txt"
      sha256: "sha256:__FILL__"
outputs_expected:
  evidence_root: "evidence/{run_id}/"
  required_files:
    - "manifest.json"
    - "gate_report.json"
    - "verdict.json"
    - "orchestration_log.json"


EvidencePack Manifest Schema
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["run_id", "timestamp", "pipeline_id", "inputs", "outputs", "gates"],
  "properties": {
    "run_id": { "type": "string" },
    "git_sha": { "type": "string" },
    "timestamp": { "type": "string", "format": "date-time" },
    "pipeline_id": { "type": "string" },
    "operator": { "type": "string" },
    "inputs": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["input_id", "path", "hash"],
        "properties": {
          "input_id": { "type": "string" },
          "path": { "type": "string" },
          "hash": { "type": "string" }
        }
      }
    },
    "outputs": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["output_id", "path", "hash"],
        "properties": {
          "output_id": { "type": "string" },
          "path": { "type": "string" },
          "hash": { "type": "string" }
        }
      }
    },
    "gates": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["gate_id", "status", "evidence_ptr"],
        "properties": {
          "gate_id": { "type": "string" },
          "status": { "type": "string", "enum": ["PASS", "FAIL", "RADAR_ONLY"] },
          "evidence_ptr": { "type": "string" }
        }
      }
    },
    "environment": {
      "type": "object",
      "properties": {
        "backend": { "type": "string" },
        "python_version": { "type": "string" },
        "node_version": { "type": "string" }
      }
    }
  },
  "additionalProperties": false
}


________________


附錄D：Coverage Matrix
[ANCHOR:SPLMVP-APPX-D]
Matrix-1：藍圖SSOT → 新版RUNBOOK
藍圖條目
	藍圖錨點
	RUNBOOK落點
	落地方式
	狀態
	Authority Stack
	BP-AUTHORITY-STACK
	§2.1 SPLMVP-AUTHORITY-REF
	引用
	COVERED
	Scope-Lock
	BP-SCOPE-LOCK
	§2.3 SPLMVP-SCOPE-LOCK
	引用
	COVERED
	Tripwires
	BP-TRIPWIRES
	§1.5 R-11, R-12
	引用
	COVERED
	交付順序
	BP-DELIVERY-ORDER
	§3.1 SPLMVP-DELIVERY-ORDER
	引用+步驟
	COVERED
	15子系統
	BP-SUBSYSTEM-LIST
	§8.1 SPLMVP-SUBSYS-WHITELIST
	引用+行為
	COVERED
	7 Gate分類
	BP-7-GATE-CLASSES
	§7.2 SPLMVP-7-GATE-CLASSES
	引用
	COVERED
	8 Gate模板
	BP-8-GATE-TEMPLATES
	§7.3 SPLMVP-8-GATE-TEMPLATES
	引用+工程層
	COVERED
	GateRunner
	BP-GATERUNNER
	§7.5.2 SPLMVP-GATERUNNER
	引用+落地
	COVERED
	Evidence Pack
	BP-EVIDENCE-SCHEMA
	§7.6 SPLMVP-EVIDENCE-PACK
	引用+Schema
	COVERED
	3 Pipeline
	BP-3-PIPELINES
	§6.1 SPLMVP-PIPELINE-ABC
	引用+步驟
	COVERED
	XQ唯一下單端
	BP-XQ-SOLE-ENDPOINT
	§1.4 SPLMVP-XQ-SOLE
	引用
	COVERED
	Fail-Closed
	BP-FAIL-CLOSED
	§2.2 SPLMVP-FAIL-CLOSED
	引用
	COVERED
	HITL停止線
	BP-HITL-STOPLINE
	§8.2.11 SPLMVP-CA-EXECUTE
	引用+stopline
	COVERED
	台股時序不變量
	BP-TW-INVARIANTS
	§5.2.4 SPLMVP-T0T1-ROUTE
	引用+路由
	COVERED
	Agent雙情境
	BP-AGENT-DUAL-CONTEXT
	§6.3 vs §6.4
	分章
	COVERED
	T0/T1路由
	BP-T0-T1-ROUTING
	§5.2.4 SPLMVP-T0T1-ROUTE
	引用+模板
	COVERED
	Mini Core Four
	BP-MINI-CORE-FOUR
	§5.3 SPLMVP-MINI-CORE-FOUR
	引用+Schema
	COVERED
	CR_OPEN
	BP-CR-OPEN-REGISTER
	§10 SPLMVP-S10-CR-OPEN
	引用+Ledger
	COVERED
	覆蓋率：18/18 = 100%
Matrix-2：需求總表A/B → 新版RUNBOOK


=== 需求總表A（34條）===
需求ID        需求摘要        RUNBOOK落點        Gate        狀態
A-1        SubP1-LITE+MVP雙重目的        §1.1 SPLMVP-DOC-POSITIONING        -        COVERED
A-2        P0-Q&A需求覆蓋        §3.2 SPLMVP-E2E-SPINE        -        COVERED
A-3        15子系統核心功能可交付        §8 SPLMVP-S8-SUBSYS        G-SCHEMA        COVERED
A-4        MVP版最小返工        §3.1 SPLMVP-DELIVERY-ORDER        -        COVERED
A-5        METHOD→BACKTEST完整功能        §8.2.5/§8.2.6 CA-METHOD/CA-BACKTEST        G-BT-H        COVERED
A-6        開發步驟順序        §3.1 SPLMVP-DELIVERY-ORDER        -        COVERED
A-7        XQ/XS v0連接性驗證        §4.2 SPLMVP-PHASE-1        G-XQ-PARITY        COVERED
A-8        子系統MVP最小行為產出績效        §8.2 各子系統        -        COVERED
A-9        最小行為綁最小Gate        §8.2 gate_binding欄位        -        COVERED
A-10        XQ付費模組連動        §1.4 SPLMVP-XQ-SOLE        -        COVERED
A-11        作坊精品版QA Kit        §7 SPLMVP-S7-GATE        -        COVERED
A-12        8個固定模板Gate        §7.3 SPLMVP-8-GATE-TEMPLATES + 附錄A        -        COVERED
A-13        Walking Skeleton先行        §3.2 SPLMVP-E2E-SPINE        -        COVERED
A-14        Mini Core Four每子系統        §5.3 SPLMVP-MINI-CORE-FOUR        G-SCHEMA        COVERED
A-15        WP單檔三合一規格        §5.2 SPLMVP-WP-TEMPLATE        -        COVERED
A-16        T0/T1雙路由        §5.2.4 SPLMVP-T0T1-ROUTE        -        COVERED
A-17        單人作坊精品級Gate最小集        §7.3 SPLMVP-8-GATE-TEMPLATES        -        COVERED
A-18        GateKit共享模組        §7.5 SPLMVP-GATEKIT-ENG        -        COVERED
A-19        GateRunner超薄執行器        §7.5.2 SPLMVP-GATERUNNER        -        COVERED
A-20        Evidence Pack三件套        §7.6 SPLMVP-EVIDENCE-PACK        -        COVERED
A-21        手動上傳→MVP全自動產出XS        §6.4.1 SPLMVP-DAILY-WORKFLOW        -        COVERED
A-22        Claude Code + Codex協作        §6.3 SPLMVP-AGENT-DEV        -        COVERED
A-23        三人三管線Pipeline        §6.1 SPLMVP-PIPELINE-ABC        -        COVERED
A-24        Handoff manifest契約        §6.2 SPLMVP-HANDOFF-ARTIFACT        -        COVERED
A-25        第三方AI/LLM驗收        §6.4.2 SPLMVP-3RD-PARTY-REVIEW        -        COVERED
A-26        Fail-Closed預設行為        §2.2 SPLMVP-FAIL-CLOSED        -        COVERED
A-27        HITL停止線        §8.2.11 CA-EXECUTE stopline        G-HITL-LOG        COVERED
A-28        XQ唯一下單端        §1.4 SPLMVP-XQ-SOLE        -        COVERED
A-29        CR_OPEN待決登記        §10 SPLMVP-S10-CR-OPEN        -        COVERED
A-30        Scope-Lock防飄移        §2.3 SPLMVP-SCOPE-LOCK        -        COVERED
A-31        Authority Stack引用        §2.1 SPLMVP-AUTHORITY-REF        -        COVERED
A-32        One-rule-one-place        附錄E SPLMVP-APPX-E-PLACEMENT        -        COVERED
A-33        EvidencePack三件套schema        附錄C SPLMVP-APPX-C        G-SCHEMA        COVERED
A-34        Agent/非Agent一鍵切換        §6.5 SPLMVP-AGENT-TOGGLE        -        COVERED


需求總表A覆蓋率：34/34 = 100%


=== 需求總表B第一部分（25條使用需求）===
需求ID        需求摘要        RUNBOOK落點        Gate        狀態
B-01        教材蒐集MVP行為        §8.2.1 CA-WRC        G-SRC        COVERED
B-02        語料庫MVP行為        §8.2.2 CA-CORPUS        G-SRC        COVERED
B-03        蒸餾MVP行為        §8.2.3 CA-DISTILL        G-SEG-L        COVERED
B-04        原語庫MVP行為        §8.2.4 CA-DSL        G-SCHEMA        COVERED
B-05        方法制定MVP行為        §8.2.5 CA-METHOD        G-SRC        COVERED
B-06        回測驗證MVP行為        §8.2.6 CA-BACKTEST        G-BT-H        COVERED
B-07        技術分析MVP行為        §8.2.7 CA-TA        G-CONF-L        COVERED
B-08        選股MVP行為        §8.2.8 CA-SELECT        G-CONF-L        COVERED
B-09        XS轉譯MVP行為        §8.2.9 CA-TRANSLATE        G-XQ-PARITY        COVERED
B-10        盯盤MVP行為        §8.2.10 CA-WATCH        G-HITL-LOG        COVERED
B-11        操盤MVP行為        §8.2.11 CA-EXECUTE        G-HITL-LOG        COVERED
B-12        績效分析MVP行為        §8.2.12 CA-PERFORM        G-CONF-L        COVERED
B-13        治理MVP行為        §8.2.13 CA-GOVERN        G-SCHEMA        COVERED
B-14        協作MVP行為        §8.2.14 CA-COLLAB        G-SCHEMA        COVERED
B-15        桌面入口MVP行為        §8.2.15 CA-UI        G-RUN        COVERED
B-16        盤中時序不變量        §5.2.4 T0規則        -        COVERED
B-17        隔日沖時序不變量        §5.2.4 T1規則        -        COVERED
B-18        HITL人工確認        §8.2.11 stopline        G-HITL-LOG        COVERED
B-19        XQ匯入流程        §6.4.1 步驟4        -        COVERED
B-20        盤後績效回饋        §6.4.1 步驟5-6        -        COVERED
B-21        方法升級循環        §6.4.1 步驟6        -        COVERED
B-22        Evidence落盤        §7.6 三件套        -        COVERED
B-23        Replay Contract        §7.7 三級標準        -        COVERED
B-24        Agent安全規約        §6.3.6 SPLMVP-AGENT-SECURITY        -        COVERED
B-25        降級容災策略        §6.5 SPLMVP-AGENT-TOGGLE        -        COVERED


需求總表B第一部分覆蓋率：25/25 = 100%


=== 需求總表B第二部分（50條擴展需求）===
需求ID        需求摘要        RUNBOOK落點        Gate        狀態
101        15子系統核心功能可交付        §8 SPLMVP-S8-SUBSYS        各子系統Gate        COVERED
102        MVP版最小返工        §3.1 SPLMVP-DELIVERY-ORDER        -        COVERED
103        METHOD→BACKTEST完整核心功能        §8.2.5/§8.2.6        G-BT-H        COVERED
104        單人作坊精品級標準        §7 SPLMVP-S7-GATE        -        COVERED
105a        WRC絕對可用定義        §8.2.1 verify_min        G-SRC        COVERED
105b        CORPUS絕對可用定義        §8.2.2 verify_min        G-SRC        COVERED
105c        DISTILL絕對可用定義        §8.2.3 verify_min        G-SEG-L        COVERED
105d        DSL絕對可用定義        §8.2.4 verify_min        G-SCHEMA        COVERED
105e        METHOD絕對可用定義        §8.2.5 verify_min        G-SRC        COVERED
105f        BACKTEST絕對可用定義        §8.2.6 verify_min        G-BT-H        COVERED
105g        TA絕對可用定義        §8.2.7 verify_min        G-CONF-L        COVERED
105h        SELECT絕對可用定義        §8.2.8 verify_min        G-CONF-L        COVERED
106        勝率>40%統計門檻        §10.2 CR_OPEN-006        G-CONF-L        Route-Out
107        8個Gate模板        §7.3 + 附錄A        -        COVERED
108        GateRunner不做平台化        §7.5.2 不做清單        -        COVERED
109        Golden set抽樣        §7.3 G-SEG-L        -        COVERED
110        Drift記錄機制        §7.4 drift_log欄位        -        COVERED
111        MVP Agent全自動化        §6.4.1 SPLMVP-DAILY-WORKFLOW        -        COVERED
112        Codespaces雲端執行        §6.3.2 SPLMVP-CODESPACES        -        COVERED
113        Local降級模式        §6.5 local-manual        -        COVERED
114        TRANSLATE絕對可用定義        §8.2.9 verify_min        G-XQ-PARITY        COVERED
115        WATCH絕對可用定義        §8.2.10 verify_min        G-HITL-LOG        COVERED
116        EXECUTE絕對可用定義        §8.2.11 verify_min        G-HITL-LOG        COVERED
117        PERFORM絕對可用定義        §8.2.12 verify_min        G-CONF-L        COVERED
118        GOVERN絕對可用定義        §8.2.13 verify_min        G-SCHEMA        COVERED
119        COLLAB絕對可用定義        §8.2.14 verify_min        G-SCHEMA        COVERED
120        UI絕對可用定義        §8.2.15 verify_min        G-RUN        COVERED
121        Pipeline A SpecPack        §6.1.1 SPLMVP-SPECPACK        -        COVERED
122        Pipeline B StrategyPack        §6.1.2 SPLMVP-STRATEGYPACK        -        COVERED
123        Pipeline C XSPack        §6.1.3 SPLMVP-XSPACK        -        COVERED
124        Pipeline B-Learn FeedbackPack        §6.1 Pipeline B-Learn        -        COVERED
125        Handoff不越界        §6.2 交接契約        -        COVERED
126        PR審核機制        §6.2 審核機制        -        COVERED
127        Manifest hash驗證        §7.6 inputs/outputs hash        -        COVERED
128        Gate report schema        附錄C gate_report schema        G-SCHEMA        COVERED
129        WI操作卡schema        §5.1 SPLMVP-WI-SCHEMA        -        COVERED
130        Front-Matter模板        §5.2.3 SPLMVP-FRONT-MATTER        -        COVERED
131        Risk Top10防線        §9.1 Top 10風險        -        COVERED
132        3個雷防線        §9.2 SPLMVP-3-PITFALLS        -        COVERED
133        Preflight 18/18        §0.1 Inputs Manifest        -        COVERED
134        Authority Stack引用        §2.1 SPLMVP-AUTHORITY-REF        -        COVERED
135        Scope-Lock引用        §2.3 SPLMVP-SCOPE-LOCK        -        COVERED
136        Tripwires引用        §1.5 R-11/R-12        -        COVERED
137        Phase 0-5不可變更        §3.1 交付順序        -        COVERED
138        E2E閉環圖        §3.2 SPLMVP-E2E-SPINE        -        COVERED
139        WI卡ADR說明        §5.5 ADR-RB-001        -        COVERED
140        Issue Closure Table        附錄J SPLMVP-APPX-J        -        COVERED
141        Anti-Regression Map        附錄K SPLMVP-APPX-K        -        COVERED
142        Crosswalk evidence_ptr        附錄H SPLMVP-EVIDENCE-PTR-EXAMPLES        -        COVERED
143        術語表        附錄G SPLMVP-APPX-G        -        COVERED
144        Changelog        附錄F SPLMVP-APPX-F        -        COVERED
145        Blueprint Patch Plan        附錄L SPLMVP-APPX-L        -        COVERED
146        Quick Index        SPLMVP-QUICK-INDEX-V140        -        COVERED
147        AI Reader Guide        SPLMVP-AI-READER-GUIDE        -        COVERED
148        防幻覺硬規則        SPLMVP-ANTI-HALLUCINATION        -        COVERED
149        Diátaxis分層        SPLMVP-DIATAXIS        -        COVERED
150        RAG-Triad指標        SPLMVP-RAG-TRIAD        -        COVERED


________________


附錄E：One-rule-one-place Placement Table
[ANCHOR:SPLMVP-APPX-E-PLACEMENT]
防雙憲法檢查表
Rule類型
	唯一存放處
	引用處錨點
	防分裂檢查
	Fail-Closed行為
	Authority Stack
	藍圖 BP-AUTHORITY-STACK
	RUNBOOK §2.1 SPLMVP-AUTHORITY-REF
	grep "A0-A9" in RUNBOOK → 應為0次
	若發現定義 → 刪除改引用
	Conflict Rule
	藍圖 BP-AUTHORITY-STACK
	RUNBOOK §2.1
	grep "高順位覆蓋" in RUNBOOK正文 → 應為引用句
	若發現獨立定義 → 改引用
	Scope-Lock
	藍圖 BP-SCOPE-LOCK
	RUNBOOK §2.3 SPLMVP-SCOPE-LOCK
	比對In/Out-of-Scope清單 → 應一致
	若發現差異 → 以藍圖為準
	Tripwires
	藍圖 BP-TRIPWIRES
	RUNBOOK §1.5
	grep "TW-00x" in RUNBOOK → 應為引用
	若發現自定義 → 刪除
	7 Gate分類
	藍圖 BP-7-GATE-CLASSES
	RUNBOOK §7.2
	grep "G5-A~G" 定義 → 應為引用
	若發現自定義 → 改引用
	8 Gate模板
	藍圖 BP-8-GATE-TEMPLATES
	RUNBOOK §7.3
	比對Gate清單 → 應一致
	若發現第9個 → 刪除
	15子系統白名單
	藍圖 BP-SUBSYSTEM-LIST
	RUNBOOK §8.1
	比對子系統清單 → 應一致
	若發現第16個 → 刪除
	XQ唯一下單端
	藍圖 BP-XQ-SOLE-ENDPOINT
	RUNBOOK §1.4
	grep "唯一下單端" → 應為引用
	若發現放寬 → BLOCK
	Fail-Closed原則
	藍圖 BP-FAIL-CLOSED
	RUNBOOK §2.2
	grep "Fail-Closed" 定義 → 應為引用
	若發現差異 → 以藍圖為準
	Mini Core Four
	藍圖 BP-MINI-CORE-FOUR
	RUNBOOK §5.3
	比對4件定義 → 應一致
	若發現第5件 → 刪除
	Blueprint Patch Plan（需回填藍圖）
目前狀態：無需回填項目。所有規則已正確存放於藍圖SSOT，RUNBOOK僅引用。
________________


附錄F：Changelog
[ANCHOR:SPLMVP-APPX-F]
版本變更記錄
版本
	日期
	變更摘要
	作者
	v0.1.0-DRAFT
	2026-01-15
	初版草案
	AI Integrator
	v1.0.0
	2026-01-15
	定案新版：整合升級修補方案、100%落地67個Patch
	AI Integrator + Human Review
	v1.1.0
	2026-01-15
	修補版：分離開發/使用、補齊WP模板、補齊stopline
	AI Integrator + Human Review
	v1.2.0
	2026-01-16
	重大升級重構：雙憲法降級、One-rule-one-place落地、審查報告全量結案
	AI Integrator + Human Review
	v1.3.0
	2026-01-17
	新增Cowork/Skills整合章節（§6.3.7, §6.3.8, §6.3.9）
新增Ops禁用宣告（§6.4.4）
新增Input Trust Tier操作規範（§6.6）
新增Staging-only規範（§6.7）
新增Destructive兩段式規範（§6.8）
新增MVS定義（§6.9）
擴充Evidence Pack rollback規格
新增附錄M/N/O
	AI Integrator + Human Review
	v1.4.0
	2026-01-18
	新增四大高槓桿Skills執行指引（§6.3.8.2）、CR_OPEN狀態對齊表（§10）、Solo-Mode HITL操作規範（§6.8.7）、Web Evidence Index引用（附錄M）、Verified Status處置SOP（附錄N）
	AI Integrator + Human Review
	

        
        
________________
附錄G：術語表
[ANCHOR:SPLMVP-APPX-G]
術語
	定義
	SubP1-LITE
	P1內部工序，為子系統建立最小交付映射與局部收斂
	MVP Spine
	最小可用閉環（MVR），不是最小文件集
	Walking Skeleton
	端到端可跑通的最薄系統骨架
	Mini Core Four (MC4)
	每個子系統的四件核心文檔：SS_README/SS_SRS/SS_ARCH/SS_DELIVER
	HITL
	Human-In-The-Loop，人機介入點
	GateKit
	G5共享Gate模板+執行器+報告格式
	GateRunner
	超薄執行器：讀manifest→執行→產三件套
	SpecPack
	Pipeline A產出：偽代碼/原語/DSL規格包
	StrategyPack
	Pipeline B-Strategy產出：方法卡/回測報告包
	XSPack
	Pipeline C產出：XS腳本/選股/故事卡包
	FeedbackPack
	Pipeline B-Learn產出：績效報告/升級提案包
	Fail-Closed
	缺輸入/缺證據/缺驗證→視為未完成，阻斷下游
	EvidencePack
	每次pipeline產出的三件套（manifest/gate_report/run_log）
	MRP
	Merge-Readiness Pack，結構化證據包
	BLOCK_RELEASE
	Gate Policy：阻斷發布，不得進入下游
	RADAR_ONLY
	Gate Policy：記錄但不阻斷，標記風險
	EXECUTE_DISABLED
	Gate Policy：禁止執行但可研究/回測
	CR_OPEN
	Change Request - Open，待決事項登記
	evidence_ptr
	證據指標，指向實際證據檔案的路徑
	T0_DAYTRADE
	當沖模式：當日13:20前強制平倉
	T1_SWING
	隔日沖模式：持倉過夜，次日收盤前平倉
	One-rule-one-place
	每條規則只能存在於藍圖或RUNBOOK其一的原則
	Implementation SSOT
	實作層單一真相來源（本RUNBOOK定位）
	規劃憲法SSOT
	規劃層單一真相來源（藍圖定位）
	WP
	Work Package 單檔三合一（README+Runbook+WI）
	Handoff Artifact
	Pipeline交接產物結構
	ACL
	Access Control List，命令白/黑名單
	Error Code
	GateRunner異常錯誤碼（ERR-GR-001~010）
	DoD
	Definition of Done，完成定義
	MC4
	Mini Core Four 縮寫
	N_min
	最小樣本數（統計門檻）
	Hit@K
	選股命中率指標（K=前K名）


	Signal Parity
	XS轉譯訊號一致性
	SEMVER
	Semantic Versioning，語意化版本號
	HITL
	Human-In-The-Loop，人機介入點


	MRP
	Merge-Readiness Pack，結構化證據包
	Tripwire
	踩線即失格的硬規則
	Route-Out
	範圍外內容轉出指向
	Drift Log
	語意/覆蓋率飄移記錄
	Recovery Policy
	異常恢復策略
	Escalation
	升級處置（超時/失敗時）
	

________________


附錄H：Crosswalk映射表
[ANCHOR:SPLMVP-APPX-H]
台股流程母本對照
母本段落
	流程/INV/產物
	RUNBOOK交付切片
	契約/Gate
	evidence_ptr範例
	INV-TIME-001
	13:10禁新倉
	§8.2.10 CA-WATCH
	stopline
	/evidence/watch/{run_id}/time_check.json
	INV-TIME-002
	13:20強清
	§8.2.11 CA-EXECUTE
	stopline
	/evidence/execute/{run_id}/force_close.json
	INV-TIME-003
	13:25-30 ROD-only
	§8.2.11 CA-EXECUTE
	stopline
	/evidence/execute/{run_id}/rod_only.json
	SF-00
	Preflight/多AI協作
	§4.1, §6.3
	G-SRC
	/evidence/preflight/{run_id}/manifest.json
	SF-01
	週級分析
	§8.2.7 CA-TA
	G-CONF-L
	/evidence/ta/{run_id}/weekly_pack.json
	SF-02~10
	日級/盤中/收盤後
	§8.2各子系統
	對應Gate
	/evidence/{subsystem}/{run_id}/daily_pack.json
	SF-11~17
	治理/版本
	§8.2.13 CA-GOVERN
	G-SCHEMA
	/evidence/govern/{run_id}/ssot_index.json
	evidence_ptr路徑範例
[ANCHOR:SPLMVP-EVIDENCE-PTR-EXAMPLES]
來源：[SRC:審查報告｜PATCH-RB-002｜DRIFT-002]
子系統
	evidence_ptr範例
	CA-WRC
	/evidence/wrc/{run_id}/input_manifest.json
	CA-CORPUS
	/evidence/corpus/{run_id}/corpus_snapshot.json
	CA-DISTILL
	/evidence/distill/{run_id}/distill_bundle.json
	CA-DSL
	/evidence/dsl/{run_id}/dsl_schema.json
	CA-METHOD
	/evidence/method/{run_id}/method_card.md
	CA-BACKTEST
	/evidence/backtest/{run_id}/backtest_report.json
	CA-TA
	/evidence/ta/{run_id}/weekly_pack.json
	CA-SELECT
	/evidence/select/{run_id}/hit_report.json
	CA-TRANSLATE
	/evidence/translate/{run_id}/parity_report.json
	CA-WATCH
	/evidence/watch/{run_id}/signal_report.json
	CA-EXECUTE
	/evidence/execute/{run_id}/hitl_log.json
	CA-PERFORM
	/evidence/perform/{run_id}/perf_report.json
	CA-GOVERN
	/evidence/govern/{run_id}/ssot_index.json
	CA-COLLAB
	/evidence/collab/{run_id}/bundle_check.json
	CA-UI
	/evidence/ui/{run_id}/e2e_smoke.json
	________________


附錄I：CR_OPEN詳細清單
[ANCHOR:SPLMVP-APPX-I]
詳見 §10.2 CR_OPEN Ledger。
________________


附錄K：Anti-Regression Preservation Map
[ANCHOR:SPLMVP-APPX-K]
v1.0.0 → 新版RUNBOOK對照
舊版章節/要點
	新版落點(錨點)
	狀態
	理由
	證據
	§0 Preflight
	§0 SPLMVP-S0-PREFLIGHT
	保留
	功能相同
	結構一致
	§1 Charter
	§1 SPLMVP-S1-CHARTER
	保留
	功能相同，新增雙SSOT分工
	結構一致
	§2 Authority Stack
	§2 SPLMVP-S2-AUTHORITY
	移位
	改為引用藍圖SSOT
	修復DRIFT-001
	§3 全局流程總覽
	§3 SPLMVP-S3-OVERVIEW
	保留
	功能相同
	結構一致
	§4 Stage級RUNBOOK
	§4 SPLMVP-S4-RUNBOOK
	保留
	功能相同
	結構一致
	§5 WI操作卡
	§5 SPLMVP-S5-WI-CARDS
	保留
	功能相同，新增ADR
	修復DRIFT-003
	§6 Pipeline與Agent
	§6 SPLMVP-S6-PIPELINE
	保留
	功能相同
	結構一致
	§7 Gate與EvidencePack
	§7 SPLMVP-S7-GATE
	保留
	功能相同，新增異常處理
	修復DRIFT-005
	§8 15子系統MVP最小行為
	§8 SPLMVP-S8-SUBSYS
	保留
	功能相同
	結構一致
	§9 Failure Modes
	§9 SPLMVP-S9-RISK
	保留
	功能相同
	結構一致
	§10 CR_OPEN Register
	§10 SPLMVP-S10-CR-OPEN
	保留
	功能相同
	結構一致
	附錄A 8 Gate模板
	附錄A SPLMVP-APPX-A
	保留
	功能相同
	結構一致
	附錄B 37張WI卡
	附錄B SPLMVP-APPX-B（12張）
	縮減
	ADR-RB-001說明
	修復DRIFT-003
	附錄C Manifest/Schema
	附錄C SPLMVP-APPX-C
	保留
	功能相同
	結構一致
	附錄D Coverage Matrix
	附錄D SPLMVP-APPX-D
	保留
	功能相同，補齊內容
	修復DRIFT-004
	-
	附錄E SPLMVP-APPX-E-PLACEMENT
	新增
	One-rule-one-place防線
	修復ORP-001
	附錄E Patch Register
	附錄F SPLMVP-APPX-F（Changelog）
	合併
	Changelog已包含Patch記錄
	-
	附錄F Changelog
	附錄F SPLMVP-APPX-F
	保留
	功能相同
	結構一致
	附錄G 術語表
	附錄G SPLMVP-APPX-G
	保留
	功能相同
	結構一致
	附錄H Crosswalk（無範例）
	附錄H SPLMVP-APPX-H（含範例）
	強化
	新增evidence_ptr範例
	修復DRIFT-002
	-
	附錄J SPLMVP-APPX-J
	新增
	Issue Closure Table
	稽核附錄
	-
	附錄K SPLMVP-APPX-K
	新增
	Anti-Regression Map
	稽核附錄
	-
	附錄L SPLMVP-APPX-L
	新增
	Blueprint Patch Plan
	稽核附錄
	v1.1.0 → 新版RUNBOOK對照
舊版章節/要點
	新版落點(錨點)
	狀態
	理由
	證據
	Authority Stack A1-A11
	§2.1引用BP-AUTHORITY-STACK + 增量
	重構
	修復DRIFT-001/ORP-001
	雙憲法降級
	附錄H Crosswalk（缺範例）
	附錄H（含完整範例）
	強化
	修復DRIFT-002
	15個evidence_ptr範例
	附錄B 關鍵WI卡（無ADR）
	§5.5 ADR-RB-001 + 附錄B
	強化
	修復DRIFT-003
	ADR說明存在
	其餘章節
	結構保留
	保留
	功能無退化
	結構一致
	結論：新版RUNBOOK在「實質內容」上可完整取代v1.1.0與v1.0.0，無不當簡化/省略/飄移/原意偏離。
________________


附錄L：Blueprint Patch Plan
[ANCHOR:SPLMVP-APPX-L]
需回填藍圖的補丁
目前狀態：無需回填項目。
經檢查，所有規劃層規則已正確存放於藍圖SSOT v1.2.1，本RUNBOOK v1.4.0僅引用，無需回填藍圖。
若未來發現需要回填藍圖的條目，格式如下：
patch_id: BP-PATCH-{SEQ}
target_doc: 藍圖SSOT
target_version: v1.2.1
anchor: BP-{ANCHOR}
action: INSERT | REPLACE
patch_content: |
  {完整補丁文本}
verification: |
  {驗證方法}
status: PENDING | APPLIED


________________




附錄M：Web Evidence Index（引用藍圖SSOT）
[ANCHOR:SPLMVP-APPX-M]


**SSOT位置**：藍圖SSOT v1.2.2 §9.6.2 [BP-WEB-EVIDENCE-INDEX]


本附錄為藍圖SSOT的引用，不重複定義。


##### 引用指針


| 項目 | 藍圖錨點 | 說明 |
|------|----------|------|
| Evidence Registry Table | [BP-WEB-EVIDENCE-INDEX] | WE-001~WE-015完整清單 |
| URL Registry | [BP-URL-REGISTRY] | 證據URL完整列表 |
| Evidence Credibility Tiers | [BP-EVIDENCE-TIERS] | A/B/C三級定義 |
| WE-002 UNVERIFIED處置 | [BP-WE002-HANDLING] | 永久禁止支撐normative |


##### 操作時查閱流程


當需要驗證CR_OPEN的evidence_refs時：
1. 查閱藍圖SSOT [BP-WEB-EVIDENCE-INDEX]
2. 確認evidence_id的verification_status
3. 若為UNVERIFIED → 不可支撐normative，需替代證據
4. 若需詳細URL → 查閱 [BP-URL-REGISTRY]


________________




附錄N：Verified Status處置SOP
[ANCHOR:SPLMVP-APPX-N]


**來源**：補釘建議 #7 Verified Status Downgrade Rules
**SSOT位置**：藍圖SSOT v1.2.2 [BP-VERIFIED-STATUS-RULES]


##### 處置流程圖
CR_OPEN 驗證流程 
│
 ▼
 ┌─────────────────┐ 
│ 檢查 evidence_refs │ 
└────────┬────────┘
 │ 
▼ 
┌─────────────────────────────────┐ 
│ 任一 evidence_id 為 UNVERIFIED？ │ 
└────────────┬────────────────────┘ 
│ 
┌────────┴────────┐ 
│ YES │ NO 
▼        ▼ 
┌────────────┐ ┌────────────┐ 
│ 禁止標 │ │ 可標 │ 
│ EXTERNAL_ │ │ EXTERNAL_ │ 
│ VERIFIED │ │ VERIFIED │ 
└─────┬──────┘ └────────────┘ 
│ 
▼ 
┌─────────────────┐ 
│ 登記替代證據需求 │ 
│ 或降級為 │ 
│ INTERNAL_ONLY │ 
└─────────────────┘
##### 操作步驟


**Step 1：檢查evidence_refs**
```bash
# 從CR_OPEN記錄中提取evidence_refs
evidence_refs=$(jq -r '.evidence_refs[]' cr_open_record.json)


# 查詢每個evidence的verification_status
for eid in $evidence_refs; do
  status=$(grep "^$eid" evidence_index.csv | cut -d, -f5)
  if [ "$status" == "UNVERIFIED" ]; then
    echo "WARNING: $eid is UNVERIFIED"
    UNVERIFIED_FOUND=true
  fi
done
```


**Step 2：處置決策**
```bash
if [ "$UNVERIFIED_FOUND" == "true" ]; then
  # 禁止標記EXTERNAL_VERIFIED
  if [ "$current_status" == "EXTERNAL_VERIFIED" ]; then
    echo "ERROR: Cannot mark EXTERNAL_VERIFIED with UNVERIFIED evidence"
    echo "ACTION: Downgrade to INTERNAL_ONLY or provide replacement evidence"
    exit 1
  fi
fi
```


**Step 3：記錄處置結果**
```bash
# 記錄至處置日誌
cat >> verified_status_handling.log << EOF
---
timestamp: $(date -Iseconds)
cr_id: ${cr_id}
evidence_refs: ${evidence_refs}
unverified_found: ${UNVERIFIED_FOUND}
action_taken: ${ACTION}
operator: solo_operator
EOF
```


##### evidence_ptr


- `/evidence/verification/{run_id}/handling_log.json`
- `/evidence/verification/{run_id}/status_change.json`




________________


文件結束
[ANCHOR:SPLMVP-RB-V140-END]
文件生成時間：2026-01-18 (Asia/Taipei) 定案版本：v1.4.0 狀態：RELEASE 審查狀態：AUDIT_INTEGRATED
Supersedes宣告：本文件完全取代v1.3.0、v1.1.0與v1.0.0，使用者不必再翻舊版。