Spartoi｜P1_ARCH（Architecture Description）
[ANCHOR:ARCH-V600-HEADER]
________________


Document Metadata
[ANCHOR:ARCH-DOC-METADATA]
項目
	內容
	外部名稱
	Spartoi P1 Architecture Description
	內部簡稱
	P1_ARCH
	版本
	v6.0.0-patch-r5
	產出日期
	2026-01-08 (Asia/Taipei)
	狀態
	RELEASE
	Supersedes
	Spartoi_P1_ARCH_v6.0.0-patch-r4, v6.0.0-patch-r3-final, v6.0.0-patch-r3, v6.0.0-patch-r2, v6.0.0, v5.2.0, v4.1.1, v3.0.0 及所有前版
	100% 取代聲明
	本版完全取代所有更早版本；依據《旗標設計裁決&修改》重構旗標體系，對齊SRS v7.0.0-patch2旗標分層架構
	升版理由
	SRS對齊修補（r5）：(1)新增§5.6 JobCard完整架構（9欄位+生命週期+失敗處理）；(2)新增§8.7台股微結構三軸約束統一架構（軸一/軸二/軸三+協調器）；(3)新增§4.19 WebTools-NA獨立架構章節（對齊SRS §3.19）
	________________


修補執行摘要
[ANCHOR:ARCH-PATCH-SUMMARY]
修補項目
	狀態
	Patch數量
	Phase 1: 結構性Anchor建立
	✅ 完成
	6 Patches
	Phase 2: SEM³完整整合
	✅ 完成
	2 Patches
	Phase 3: 核心目標與策略
	✅ 完成
	5 Patches
	Phase 4: 約束與能力補強
	✅ 完成
	5 Patches
	Phase 5: 子系統描述完善
	✅ 完成
	7 Patches
	Phase 6: Route-out與一致性
	✅ 完成
	5 Patches
	Phase 7: 術語與細節
	✅ 完成
	7 Patches
	r2小計
	✅ 全部完成
	37 Primary + 28 Sub = 65
	Phase 8: SRS對齊修補 (r3)
	✅ 完成
	12 Patches
	Phase 9: 旗標設計重構 (r4)
	✅ 完成
	6 Patches
	Phase 10: SRS對齊修補 (r5)
	✅ 完成
	6 Patches
	r3修補清單（SRS審查報告回應）
Patch ID
	問題來源
	修正內容
	PATCH-R3-001
	BLOCKER-01
	Six Core Objectives架構支撐(G1-G6)
	PATCH-R3-002
	BLOCKER-02
	Agent雙模8條需求架構完整化
	PATCH-R3-003
	BLOCKER-03
	控制面三件套架構(intent_spec/validation_hook/evidence_refs)
	PATCH-R3-004
	BLOCKER-04
	MarketProfile SSOT與SessionPolicy架構
	PATCH-R3-005
	MAJOR-01
	CA-UI決策隔離/JobCard/Capability架構
	PATCH-R3-006
	MAJOR-02
	台股微結構三軸約束完整架構
	PATCH-R3-007
	MAJOR-03
	Decision Package架構與Dual-Write機制
	PATCH-R3-008
	MAJOR-04
	降級矩陣DG-AUTO-03補齊
	PATCH-R3-009
	MAJOR-05
	Canonical Corpus Manifest/Provenance架構
	PATCH-R3-010
	MAJOR-06
	Track-A五可量測目標架構
	PATCH-R3-011
	MAJOR-07
	run_config_snapshot 10欄位對齊
	PATCH-R3-012
	MAJOR-08
	ICT台股在地化映射架構
	PATCH-R3-SUB
	子系統整併
	CA-AGENT併入CA-COLLAB維持15子系統
	r4修補清單（旗標設計裁決回應）
Patch ID
	問題來源
	修正內容
	PATCH-R4-001
	設計偏離
	版本資訊更新，標記旗標重構
	PATCH-R4-002
	裁決(1)
	Gate分層架構（Policy/Check分離）
	PATCH-R4-003
	裁決(2)
	旗標分層架構（Tier-0/Tier-1/Tier-2）對齊SRS v7.0.0
	PATCH-R4-004
	裁決(3)
	Flag Usage Matrix（子系統旗標使用）
	PATCH-R4-005
	裁決(3)
	XDOC-FLAG-CONSISTENCY Gate（跨文件一致性）
	PATCH-R4-006
	裁決(4)
	全域級必備原則條文化
	r5修補清單（SRS對齊修補）
Patch ID
	問題來源
	修正內容
	PATCH-R5-001
	-
	版本資訊更新
	PATCH-R5-002
	問題1
	JobCard完整架構（§5.6）- 9欄位+生命週期+SF綁定+Rollback
	PATCH-R5-003
	問題3
	WebTools-NA獨立架構（§4.19）- 對齊SRS §3.19
	PATCH-R5-004
	問題2
	台股微結構三軸約束統一架構（§8.7）- 軸一/軸二/軸三+協調器
	PATCH-R5-005
	目錄
	TOC更新
	PATCH-R5-006
	-
	修補摘要更新
	________________


Table of Contents（完整目錄含錨點）
[ANCHOR:ARCH-TOC]
§0 Preflight & AI Reader Guide
* §0.1 Preflight Report [ANCHOR:ARCH-PREFLIGHT]
   * PREFLIGHT-1 檔案存在性確認
   * PREFLIGHT-2 inputs_manifest（版本/指紋表）[ANCHOR:ARCH-INPUTS-MANIFEST]
   * PREFLIGHT-3 Authority Stack（權威順位）[ANCHOR:ARCH-AUTHORITY-STACK]
* §0.2 Scope Lock & Boundary Declaration [ANCHOR:ARCH-SCOPE-LOCK]
   * ARCH Boundary Lock [ANCHOR:ARCH-BOUNDARY-LOCK]
   * Document Responsibility Split [ANCHOR:ARCH-DOC-SPLIT]
   * Candidate vs Gate Rule [ANCHOR:ARCH-CANDIDATE-RULE]
   * SFHB Demotion [ANCHOR:ARCH-SFHB-DEMOTION]
* §0.3 AI Reader Guide [ANCHOR:ARCH-AI-READER-GUIDE]
   * §0.3.1 強制檢索路徑
   * §0.3.2 Quick Index（關鍵詞→anchor）
   * §0.3.3 Null-Answer Template [ANCHOR:ARCH-NULL-ANSWER]
   * §0.3.4 Anti-Hallucination Rules [ANCHOR:ARCH-ANTI-HALLUCINATION]
   * §0.3.5 全域級必備原則 [ANCHOR:ARCH-GLOBAL-PRINCIPLES] [NEW:PATCH-R4-006]
   * §0.3.6 Candidate Fence Enforcement [ANCHOR:ARCH-CANDIDATE-FENCE] [NEW:PATCH-064]
* §0.4 Route-Out Map（Topic SSOT）[ANCHOR:ARCH-ROUTE-OUT-MAP]
§1 Document Overview
* §1.1 Purpose & Scope [ANCHOR:ARCH-PURPOSE]
* §1.2 Goals [ANCHOR:ARCH-GOALS]
* §1.3 Non-Goals [ANCHOR:ARCH-NON-GOALS]
* §1.4 Stakeholders [ANCHOR:ARCH-STAKEHOLDERS]
§2 Architecture Framework (ISO 42010)
* §2.1 Viewpoint Catalog [ANCHOR:ARCH-VIEWPOINT-CATALOG]
* §2.2 View Index [ANCHOR:ARCH-VIEW-INDEX]
* §2.3 Architecture Vocabulary [ANCHOR:ARCH-VOCABULARY]
§3 Architecture Views（最小視圖集）
* §3.1 Context View [ANCHOR:ARCH-CONTEXT-VIEW]
* §3.2 Container View [ANCHOR:ARCH-CONTAINER-VIEW]
   * §3.2.1 CA-UI Interface Matrix [ANCHOR:ARCH-CA-UI-INTERFACE-MATRIX]
   * §3.2.6 Orchestrator Architecture [ANCHOR:ARCH-ORCHESTRATOR] [NEW:PATCH-052]
   * §3.2.7 Artifact Store Architecture [ANCHOR:ARCH-ARTIFACT-STORE] [NEW:PATCH-053]
   * §3.2.8 Validators Architecture [ANCHOR:ARCH-VALIDATORS] [NEW:PATCH-054]
   * §3.2.9 Evals Runner Architecture [ANCHOR:ARCH-EVALS-RUNNER] [NEW:PATCH-012-R]
   * §3.2.10 Container View ASCII Summary [ANCHOR:ARCH-CONTAINER-ASCII] [NEW:PATCH-065]
* §3.3 Deployment View [ANCHOR:ARCH-DEPLOYMENT-VIEW]
* §3.4 Browser Automation Assistant Architecture [ANCHOR:ARCH-AUTOMATION-ASSISTANT] [NEW:PATCH-011-R]
§4 System Decomposition（15子系統）
* §4.1 Subsystem Overview [ANCHOR:ARCH-SUBSYSTEM-OVERVIEW]
* §4.2 CA-WRC [ANCHOR:ARCH-CA-WRC]
* §4.3 CA-CORPUS [ANCHOR:ARCH-CA-CORPUS]
   * §4.2.5 Multi-Modal Pipeline Architecture [ANCHOR:ARCH-MULTIMODAL-PIPELINE] [NEW:PATCH-024-R]
   * §4.2.6 Historical Data Architecture [ANCHOR:ARCH-HISTORICAL-DATA]
* §4.4 CA-DISTILL [ANCHOR:ARCH-CA-DISTILL]
* §4.5 CA-DSL [ANCHOR:ARCH-CA-DSL]
   * CA-DSL純原語政策 [ANCHOR:ARCH-CA-DSL-PURITY]
* §4.6 CA-METHOD [ANCHOR:ARCH-CA-METHOD]
* §4.7 CA-BACKTEST [ANCHOR:ARCH-CA-BACKTEST]
   * §4.7.5 Overfitting Defense Architecture [ANCHOR:ARCH-OVERFITTING-DEFENSE] [NEW:PATCH-025-R]
* §4.8 CA-TA [ANCHOR:ARCH-CA-TA]
* §4.9 CA-SELECT [ANCHOR:ARCH-CA-SELECT]
* §4.10 CA-TRANSLATE [ANCHOR:ARCH-CA-TRANSLATE]
* §4.11 CA-WATCH [ANCHOR:ARCH-CA-WATCH]
* §4.12 CA-EXECUTE [ANCHOR:ARCH-CA-EXECUTE]
* §4.13 CA-PERFORM [ANCHOR:ARCH-CA-PERFORM]
   * §4.15 CA-PERFORM Dual-Track Architecture [ANCHOR:ARCH-CA-PERFORM-DUALTRACK] [NEW:PATCH-057]
* §4.14 CA-COLLAB (含Agent模式) [ANCHOR:ARCH-CA-COLLAB] [MERGED:CA-AGENT]
* §4.15 CA-UI [ANCHOR:ARCH-CA-UI]
* §4.16 CA-GOVERN [ANCHOR:ARCH-CA-GOVERN]
* §4.17 LLM Factory Arbiter Architecture [ANCHOR:ARCH-ARBITER] [NEW:PATCH-055]
* §4.18 ICT Technique Hot-Swap Architecture [ANCHOR:ARCH-ICT-HOTSWAP] [NEW:PATCH-001]
* §4.19 WebTools-NA協作架構 [ANCHOR:ARCH-WTNA] [NEW:PATCH-R5-003]
   * §4.19.1 WebTools-NA定義與範圍 [ANCHOR:ARCH-WTNA-SCOPE]
   * §4.19.2 人工複製貼上工作流 [ANCHOR:ARCH-WTNA-WORKFLOW]
   * §4.19.3 必備工件 [ANCHOR:ARCH-WTNA-ARTIFACTS]
   * §4.19.4 與Browser Automation的關係 [ANCHOR:ARCH-WTNA-VS-BA]
   * §4.19.5 三路徑路由架構 [ANCHOR:ARCH-THREE-PATH-ROUTING]
§5 Spartoi Flow（SF主鍵）
* §5.1 SF Primary Key Policy [ANCHOR:ARCH-SF-PRIMARY-KEY]
* §5.2 SF Node Index [ANCHOR:ARCH-SF-INDEX]
* §5.3 SF Data Flow [ANCHOR:ARCH-SF-DATAFLOW]
   * §5.3.2 Evidence Chain Table [ANCHOR:ARCH-EVIDENCE-CHAIN] [NEW:PATCH-003]
* §5.4 SF-11 HITL Decision Gate [ANCHOR:ARCH-HITL-GATE]
* §5.5 T0/T1 Dual Mode [ANCHOR:ARCH-T0-T1-MODE]
* §5.6 JobCard Architecture [ANCHOR:ARCH-JOBCARD] [NEW:PATCH-R5-002]
   * §5.6.1 JobCard結構定義 [ANCHOR:ARCH-JOBCARD-STRUCT]
   * §5.6.2 JobCard生命週期 [ANCHOR:ARCH-JOBCARD-LIFECYCLE]
   * §5.6.3 JobCard與SF節點綁定 [ANCHOR:ARCH-JOBCARD-SF-BINDING]
   * §5.6.4 JobCard失敗處理與Rollback [ANCHOR:ARCH-JOBCARD-ROLLBACK]
§6 Control Plane（控制面）
* §6.0 Gate分層架構 [ANCHOR:ARCH-GATE-LAYER] [NEW:PATCH-R4-002]
   * §6.0.1 Gate Policy（裁決層）[ANCHOR:ARCH-GATE-POLICY]
   * §6.0.2 Gate ID（檢核層）[ANCHOR:ARCH-GATE-ID]
* §6.1 Flag Registry [ANCHOR:ARCH-FLAG-REGISTRY] [UPDATED:PATCH-R4-003]
   * §6.1.1 旗標分層架構（Flag Tiering）[ANCHOR:ARCH-FLAG-TIERING]
   * §6.1.2 Flag Usage Matrix [ANCHOR:ARCH-FLAG-USAGE-MATRIX] [NEW:PATCH-R4-004]
   * §6.1.3 XDOC-FLAG-CONSISTENCY Gate [ANCHOR:ARCH-XDOC-FLAG-GATE] [NEW:PATCH-R4-005]
* §6.2 Degrade Matrix [ANCHOR:ARCH-DEGRADE-MATRIX]
* §6.3 Run Config Snapshot [ANCHOR:ARCH-RUN-CONFIG-SNAPSHOT]
* §6.4 Control Plane Event Log [ANCHOR:ARCH-CONTROL-EVENT-LOG]
* §6.7 SEM³ Three-Gate Architecture [ANCHOR:ARCH-SEM3-COMPLETE] [NEW:PATCH-059]
§7 Key Architectural Decisions
[ANCHOR:ARCH-KEY-DECISIONS]
* §7.5 Six Core Objectives Architecture Support [ANCHOR:ARCH-SIX-OBJECTIVES] [UPDATED:PATCH-R3-001]
§8 Major Constraints & Quality Drivers
[ANCHOR:ARCH-CONSTRAINTS]
* §8.4 Time Window Constraints Table [ANCHOR:ARCH-TIME-WINDOW-CONSTRAINTS] [NEW:PATCH-002]
* §8.5 Attended-First Architecture Strategy [ANCHOR:ARCH-ATTENDED-FIRST] [NEW:PATCH-056]
* §8.6 Degrade Rules Architecture [ANCHOR:ARCH-DEGRADE-RULES]
* §8.7 台股微結構三軸約束架構 [ANCHOR:ARCH-TWMS-AXIS] [NEW:PATCH-R5-004]
   * §8.7.1 軸一：時間窗約束 [ANCHOR:ARCH-TWMS-AXIS1]
   * §8.7.2 軸二：流動性約束 [ANCHOR:ARCH-TWMS-AXIS2]
   * §8.7.3 軸三：交易規則約束 [ANCHOR:ARCH-TWMS-AXIS3]
   * §8.7.4 三軸檢查協調器 [ANCHOR:ARCH-TWMS-CHECKER]
§9 Agent SKILLS Dual-Mode Architecture
* §9.1 Agent Mode Switch [ANCHOR:ARCH-AGENT-MODE]
* §9.2 Skills Registry Slot [ANCHOR:ARCH-SKILLS-REGISTRY]
* §9.3 Agent Guardrails [ANCHOR:ARCH-AGENT-GUARDRAILS]
§10 Observability & Governance（可觀測性與治理）
[ANCHOR:ARCH-OBSERVABILITY]
§10.1 三通道可觀測性架構
[ANCHOR:ARCH-OBSERVABILITY-CHANNELS]
通道
	內容
	產生者
	消費者
	存放位置
	Logs
	系統日誌/錯誤/警告
	全部子系統
	CA-UI, 運維
	/logs/{subsystem}/
	Events
	業務事件/狀態變更
	CA-GOVERN產出
	CA-UI, CA-PERFORM
	/events/
	Metrics
	效能指標/業務指標
	CA-PERFORM計算
	CA-UI, 報表
	/metrics/
	責任切割：
職責
	負責子系統
	說明
	Logs產生
	全部
	每個子系統產生自己的日誌
	Events裁決
	CA-GOVERN
	決定哪些事件需要記錄
	Metrics計算
	CA-PERFORM
	聚合計算效能/業務指標
	展示呈現
	CA-UI
	統一展示三通道資料
	§10.2 Governance架構
[ANCHOR:ARCH-GOVERNANCE]
治理職責：
* CA-GOVERN作為治理SSOT
* 控制面三件套（Flag/Degrade/Snapshot）由CA-GOVERN管理
* Gate驗證由CA-GOVERN執行
Route-Out：可觀測性詳細規格見LBP-E(Fitness)
§12 RTM架構映射（Requirements Traceability Matrix - Architecture Layer）
[ANCHOR:ARCH-RTM-MAPPING]
本章提供需求到架構的追溯映射（架構層）。驗收條件Route-Out至SRS。
§12.1 REQ21核心需求映射
REQ21-ID
	需求摘要
	ARCH章節
	覆蓋子系統
	驗收Route-Out
	REQ21-01
	教材蒐集與可追溯
	§4.2, §4.3
	CA-WRC, CA-CORPUS
	SRS §3.1
	REQ21-02
	禁用詞政策
	§0.3, APPX-A
	CA-GOVERN
	SRS §2.2
	REQ21-03
	SF主鍵流程
	§5
	全部
	SRS §3.1
	REQ21-04
	Fail-Closed原則
	§8.1
	CA-GOVERN
	SRS §5.2
	REQ21-05
	Kill Switch
	§8.5
	CA-GOVERN, CA-EXECUTE
	SRS §5.3
	REQ21-06
	HITL人機介入
	§5.2.1 SF-11
	CA-UI, CA-GOVERN
	SRS §3.11
	REQ21-07
	可回放可追溯
	§5.3.2
	全部
	SRS §5.5
	REQ21-08
	No-API政策
	§5.1.2
	CA-COLLAB
	SRS §2.4
	REQ21-09
	控制面三件套
	§6
	CA-GOVERN
	SRS §5.1
	REQ21-10
	ICT熱插拔
	§4.18, APPX-H
	CA-METHOD
	SRS §3.20
	REQ21-11
	T0/T1雙模
	§5.5, §8.4
	CA-METHOD, CA-EXECUTE
	SRS §3.24
	REQ21-12
	Agent雙模
	§9
	CA-COLLAB
	SRS §2.4
	REQ21-13
	MarketProfile SSOT
	§4.5.4
	CA-METHOD
	SRS §3.7
	REQ21-14
	CA-DSL純原語
	§4.5
	CA-DSL
	SRS §3.7
	REQ21-15
	CA-UI全子系統連接
	§3.2.1, §4.15
	CA-UI
	SRS §3.16
	REQ21-16
	SEM³三Gate
	§6.8
	CA-METHOD, CA-DISTILL
	SRS §3.22
	REQ21-17
	Degrade Matrix
	§6.2, §8.6
	CA-GOVERN
	SRS §5.2
	REQ21-18
	Run Config Snapshot
	§6.3
	CA-GOVERN
	SRS §5.1
	REQ21-19
	Flag Registry
	§6.1
	CA-GOVERN
	SRS §5.1
	REQ21-20
	TVE等價驗證
	§4.10
	CA-TRANSLATE
	SRS §3.10
	REQ21-21
	15子系統骨架
	§4
	全部
	SRS §2.3
	覆蓋率：21/21 = 100%
Route-Out：驗收條件見SRS APPX-D(MAI)
§13 Route-Out Map（唯一指針表）
[ANCHOR:ARCH-ROUTE-OUT-COMPLETE]
§11 Drift/Conflict Ledger
[ANCHOR:ARCH-CONFLICT-LEDGER]
* §11.5 P1 Minimum Viable Closure Architecture Mapping [ANCHOR:ARCH-P1-MINIMUM-CLOSURE] [NEW:PATCH-058]
Appendices
* APPX-A Anchor Registry [ANCHOR:ARCH-APPX-A-ANCHORS]
* APPX-B Crosswalk/Legacy [ANCHOR:ARCH-APPX-B-CROSSWALK]
* APPX-C Build Report [ANCHOR:ARCH-APPX-C-BUILD-REPORT]
* APPX-D P0 Daily Task Architecture Mapping [ANCHOR:ARCH-P0-TASK-MAPPING] [NEW:PATCH-063]
________________


§0 Preflight & AI Reader Guide
§0.1 Preflight Report
[ANCHOR:ARCH-PREFLIGHT]
PREFLIGHT-1 檔案存在性確認
doc_id
	文件名稱
	可讀性
	狀態
	A-1
	Spartoi｜P1_SRS_v7.0.0
	✅
	可定位引用
	A-2
	Spartoi｜P1_SRS_v7.0.0 外掛附件合冊
	✅
	可定位引用
	B-1
	Candidate處置規則_v2
	✅
	治理語義來源
	B-2
	ΣHybrid SEM³ Gate & Fidelity Upgrade Blueprint v1.0.0
	✅
	SEM³ SSOT [NEW]
	C-1
	Spartoi｜P0-Q&A_1114
	✅
	Authority #1
	C-2
	Spartoi系統21項需求
	✅
	REQ21
	C-3
	Spartoi｜待補充需求庫
	✅
	RS-B (642條)
	C-4
	Spartoi｜StRS+SyRS_v5.2.0
	✅
	上位需求
	D-1
	P1-ICRU
	✅
	能力升級規劃
	D-2
	Planv2
	✅
	增補建議(H1-H8假說)
	E-1
	執行手冊_v2.1.0
	✅
	SF/HITL定位參照
	F-1
	LBP-B(ICD)
	✅
	ICD參照
	G-1
	審查修補方案v2.0.0
	✅
	65項Patch來源 [NEW]
	PREFLIGHT-1 結論: 全部13份文件可讀、可定位引用。✅ PASS
PREFLIGHT-2 inputs_manifest（版本/指紋表）
[ANCHOR:ARCH-INPUTS-MANIFEST]
doc_name
	doc_id
	version
	artifact_fingerprint
	top_anchors
	P0-Q&A_1114
	B0-1
	-
	SHA256:P0QA_fingerprint
	任務a-m, 痛點§1-§10
	Spartoi系統21項需求
	REQ21
	-
	SHA256:REQ21_fingerprint
	REQ21-01~REQ21-21
	Spartoi｜待補充需求庫
	RS-B
	-
	SHA256:RSB_fingerprint
	22大類642條
	StRS+SyRS
	StRS-SyRS
	v5.2.0
	SHA256:STSYRS_fingerprint
	§3-§12
	P1-ICRU
	ICRU
	v1.0.0
	SHA256:ICRU_fingerprint
	§5-§14
	Planv2
	PLANV2
	v2
	SHA256:PLANV2_fingerprint
	H1-H8
	P1_SRS
	SRS
	v7.0.0
	SHA256:SRS700_fingerprint
	§0-§14, APPX-A~I
	Candidate處置規則
	CAND-RULE
	v2.0
	SHA256:CANDRULE_fingerprint
	H0-H8
	執行手冊
	SFHB
	v2.1.0
	SHA256:SFHB_fingerprint
	§4-§7, APPX-A~F
	LBP-B(ICD)
	LBP-B
	OMITTED_BY_POLICY
	SHA256:LBPB_fingerprint
	CONTRACT-, SCHEMA-
	SEM³ Blueprint
	SEM3-UB
	v1.0.0
	SHA256:SEM3UB_fingerprint
	SGF/MSC/TVE [NEW]
	審查修補方案
	PATCH-V2
	v2.0.0
	SHA256:PATCHV2_fingerprint
	ARCHV600-PATCH-001~065 [NEW]
	PREFLIGHT-3 Authority Stack（權威順位）
[ANCHOR:ARCH-AUTHORITY-STACK]
本ARCH的裁決/衝突處置 MUST 依此順位（由高到低）：
順位
	文件
	版本
	職責
	裁決說明
	1
	P0-Q&A_1114
	-
	最高權威/系統硬約束
	不可被下位覆蓋
	2
	Spartoi系統21項需求
	REQ21
	核心硬約束
	含No-API、SEM³等
	3
	Spartoi｜待補充需求庫
	RS-B
	補齊缺口需求(642條)
	全量disposition
	4
	Spartoi｜StRS+SyRS
	v5.2.0
	上位St/Sy需求
	作RTM化以防漏條
	5
	P1-ICRU
	v1.0.0
	能力升級規劃
	62節點逐項disposition
	6
	Planv2
	v2
	增補建議
	H1-H8假說
	7
	P1_SRS
	v7.0.0
	需求SSOT
	本版主要依據
	8
	ΣHybrid SEM³ Blueprint
	v1.0.0
	SEM³ SSOT [NEW]
	三Gate治理
	衝突裁決紀錄位置: APPX Conflict Ledger [ANCHOR:ARCH-CONFLICT-LEDGER]
PREFLIGHT 結論: 全部PREFLIGHT條件滿足。✅ PASS
________________


§0.2 Scope Lock & Boundary Declaration
[ANCHOR:ARCH-SCOPE-LOCK]
ARCH Boundary Lock（不可協商）
[ANCHOR:ARCH-BOUNDARY-LOCK]
ARCH 只寫:
* ✅ 主要結構與邊界（15子系統骨架）
* ✅ 主要部署拓樸（Context/Container/Deployment View）
* ✅ 架構策略與關鍵約束（Fail-Closed原則、降級策略）
* ✅ 最小視圖集合（必要且足夠）
* ✅ Route-out Map（Topic→SSOT→Locator）
* ✅ 關鍵決策（一句結論 + ADR指針）
* ✅ 架構級能力描述（ICT熱插拔機制、可觀測性框架、ICRU能力鏈、SEM³三階驗證）[ENHANCED]
ARCH 嚴禁:
* ❌ 需求條文/驗收條件/Gate定義（SSOT: SRS）
* ❌ ICD schema欄位表/API詳規（SSOT: LBP-B）
* ❌ ADR長篇取捨論述（SSOT: ADR）
* ❌ C4畫到code level（SSOT: LBP-D）
* ❌ 安裝/操作步驟（SSOT: Runbook）
* ❌ 量化KPI/SLO/門檻數值（SSOT: SRS non-normative區）
* ❌ 演算法/策略偽代碼（SSOT: LBP-B）
Document Responsibility Split
[ANCHOR:ARCH-DOC-SPLIT]
文件
	WHAT
	WHY
	HOW-接線
	HOW-細節
	SRS
	✅
	✅
	Route-Out
	❌
	ARCH
	❌
	❌
	✅
	Route-Out
	LBP-B(ICD)
	❌
	❌
	✅
	✅
	Runbook
	❌
	❌
	❌
	✅
	Candidate vs Gate Rule
[ANCHOR:ARCH-CANDIDATE-RULE]
依據《Candidate處置規則_v2》：
* ARCH不承載任何Candidate門檻數值
* ARCH僅描述「Candidate→CR_OPEN→Fail-Closed」的架構策略與責任路由
* 門檻數值只能存在於SRS non-normative區塊
* ARCH可描述防漂移/Fail-safe機制，但不定義Gate條件值
Route-Out: Candidate治理詳細規則見《Candidate處置規則_v2》H0-H8
SFHB Demotion（Runbook降階）
[ANCHOR:ARCH-SFHB-DEMOTION]
執行手冊v2.1.0定位：
* 定位：Implementation Procedure Spec（程序規格）
* 用途：僅供「對齊SF主鍵流程與SF-11 HITL定位」參照
* 限制：不得作為需求SSOT、不得作為Route-Out目標
* 衝突處置：與SRS/ARCH衝突時，以SRS/ARCH為準
________________


§0.3 AI Reader Guide
[ANCHOR:ARCH-AI-READER-GUIDE]
§0.3.1 強制檢索路徑
AI/LLM處理本ARCH時MUST依以下順序：
1. 先讀 Authority Stack（§0.1 PREFLIGHT-3）: 理解裁決順位
2. 再讀 Scope Lock（§0.2）: 理解ARCH邊界
3. 再讀 Route-Out Map（§0.4）: 理解可Route-Out範圍
4. 使用時從 TOC 跳轉: 每節都有ANCHOR
§0.3.2 Quick Index（常用查詢鍵）
檢索鍵
	Anchor
	用途
	15子系統
	ARCH-SUBSYSTEM-OVERVIEW
	子系統骨架
	SF主鍵
	ARCH-SF-PRIMARY-KEY
	流程主鍵體系
	SF-11 HITL
	ARCH-HITL-GATE
	HITL決策門定位
	控制面三件套
	ARCH-FLAG-REGISTRY, ARCH-DEGRADE-MATRIX, ARCH-RUN-CONFIG-SNAPSHOT
	Flag/Degrade/Snapshot
	Gate分層架構
	ARCH-GATE-LAYER, ARCH-GATE-POLICY, ARCH-GATE-ID
	Policy/Check分離 [NEW:R4]
	旗標分層架構
	ARCH-FLAG-TIERING
	Tier-0/1/2 [NEW:R4]
	Flag Usage Matrix
	ARCH-FLAG-USAGE-MATRIX
	子系統旗標使用 [NEW:R4]
	跨文件一致性
	ARCH-XDOC-FLAG-GATE
	XDOC-FLAG-CONSISTENCY [NEW:R4]
	Agent雙模
	ARCH-AGENT-MODE
	NON_AGENT/AGENT_ASSIST
	T0/T1
	ARCH-T0-T1-MODE
	當沖/隔日沖雙線
	CA-UI單一入口
	ARCH-CA-UI
	UI全子系統連接
	SEM³三Gate
	ARCH-SEM3-COMPLETE
	SGF/MSC/TVE [NEW]
	ICT熱插拔
	ARCH-ICT-HOTSWAP
	Technique Registry [NEW]
	5關鍵構件
	ARCH-ORCHESTRATOR~ARCH-AUTOMATION-ASSISTANT
	架構構件 [NEW]
	§0.3.3 Null-Answer Template
[ANCHOR:ARCH-NULL-ANSWER]
當無法從本ARCH找到答案時，MUST使用以下模板：
[NULL-ANSWER]
查詢主題: {topic}
ARCH搜尋結果: 未找到/資訊不足
建議Route-Out: {SRS/LBP-B/ADR/Runbook} §{section} [ANCHOR:{anchor}]
標記: CR_OPEN/需要上游裁決


§0.3.4 Anti-Hallucination Rules（防幻覺硬規則）
[ANCHOR:ARCH-ANTI-HALLUCINATION]
規則ID
	規則名稱
	描述
	違反後果
	AH-001
	No-Source-No-Norm
	無來源依據的規範性內容不得引用
	引用無效
	AH-002
	RTM-First
	聲明覆蓋前必須查證RTM工件
	覆蓋聲明無效
	AH-003
	Fail-Closed
	不確定時假設系統會阻斷
	安全側推論
	AH-004
	Route-Out-Precise
	Route-Out目標必須存在且可定位
	Route-Out無效
	AH-005
	Candidate-Not-Gate
	Candidate值不得用於Gate判定
	Gate決議無效
	AH-006
	ARCH-Not-SRS
	ARCH不定義需求，只描述HOW
	職責混淆
	AH-007
	Anchor-Existence
	引用錨點必須在目標文件存在
	引用無效
	AH-008
	Version-Binding
	引用文件必須明確版本
	引用模糊
	禁止推論區：
* ❌ 不得推測未定義的Gate條件值
* ❌ 不得推測未定義的Schema欄位
* ❌ 不得推測子系統內部實作細節
* ❌ 不得推測運行時數值門檻
§0.3.5 全域級必備原則（寫死，避免再漂移）
[ANCHOR:ARCH-GLOBAL-PRINCIPLES] [NEW:PATCH-R4-006]
本節定義不可變的全域級原則，任何升級/修補均不得違反。
原則一：SSOT原則
* Flag Registry MUST為旗標唯一來源
* ARCH只能Route-Out指向SRS，MUST NOT自創同名異義
* 違反後果：發現同名異義旗標 → BLOCK_RELEASE + 強制合併
原則二：Safe Default
* 所有高風險旗標（Tier-0）默認MUST為更保守值
* 系統MUST支援一鍵回到安全預設
* Safe Default定義：
   * 允許型（allow_*）：默認=false（禁止）
   * 要求型（require_*）：默認=true（強制）
   * 啟用型（enable_*）：默認=false（禁用）
原則三：旗標分級 + 到期清理
* 旗標MUST依Tier-0/Tier-1/Tier-2分級
* Tier-0數量MUST≤3個
* 每個旗標MUST有退場/到期策略
* 超過到期日未處理 → RADAR_ONLY
原則四：Gate分層
* Gate體系MUST分成「裁決（Policy）」與「檢核（Check）」兩層
* gate_policy固定三態：BLOCK_RELEASE / RADAR_ONLY / EXECUTE_DISABLED
* gate_id（檢核碼）可多個，但必須映射到gate_policy
* 嚴禁混用
原則五：P1/P2邊界
* P1只要求：能產出、能稽核、能回放、能阻斷的"合約與證據"
* P2才要求：把gate_policy真的接到運行期行為
* 避免P1被gate的工程化成本拖死
Route-Out：原則詳細條文見SRS §0.4.5 [SRS-V700-GLOBAL-PRINCIPLES]
________________


§0.3.6 Candidate Fence Enforcement
[ANCHOR:ARCH-CANDIDATE-FENCE] [NEW:PATCH-064]
確保ARCH不含任何數值門檻的檢查機制。
Candidate Fence定義：
* Fence範圍：ARCH正文（§1-§11）禁止含任何數值門檻
* 允許例外：Route-Out說明中可提及「數值見[目標文件]」
* 門檻類型：百分比(%)、時間(ms/s)、數量(N)、比率
檢查規則：
規則ID
	正則模式
	說明
	處置
	FENCE-001
	≤|≥|<|> + 數字
	比較運算符+數值
	移除數值，Route-Out
	FENCE-002
	\d+%
	百分比
	移除，Route-Out
	FENCE-003
	\d+ms|\d+s
	時間單位
	移除，Route-Out
	FENCE-004
	N=\d+
	數量定義
	移除，Route-Out
	檢查工具：
# Candidate Fence Lint
grep -E "(≤|≥|<|>)\s*[0-9]|\d+%|\d+(ms|s)|N=[0-9]" ARCH.md | grep -v "Route-Out"


Route-Out目標：
* 數值門檻：SRS non-normative / Fitness
* 時序SLO：Fitness [LBP-E-*]
* 品質門檻：SRS §0.4 / Fitness
________________


§0.4 Route-Out Map（Topic SSOT）
[ANCHOR:ARCH-ROUTE-OUT-MAP]
Topic
	SSOT文件
	Locator格式
	說明
	CR_OPEN狀態
	需求條文
	SRS v7.0.0
	SRS-V700-{section}
	所有SHALL/MUST需求
	N/A
	旗標定義SSOT
	SRS v7.0.0
	SRS-V700-FLAG-TIERING
	Tier-0/1/2旗標定義
	N/A
	Gate分層定義
	SRS v7.0.0
	SRS-V700-GATE-DICT
	gate_policy+gate_id
	N/A
	全域級原則
	SRS v7.0.0
	SRS-V700-GLOBAL-PRINCIPLES
	五條硬規則
	N/A
	Gate定義
	SRS v7.0.0
	SRS-V700-GATE-{id}
	Gate Dictionary
	N/A
	驗收鉤子
	SRS v7.0.0
	MAI-{category}-{id}
	Master Acceptance Index
	N/A
	Contract Schema
	LBP-B(ICD)
	CONTRACT-{subsystem}-{id}
	介面契約
	N/A
	Data Schema
	LBP-B(ICD)
	SCHEMA-{name}
	資料結構
	N/A
	決策記錄
	ADR
	ADR-{id}
	Architecture Decision Record
	N/A
	測試規範
	LBP-E(Fitness)
	FITNESS-{id}
	適應度函數
	N/A
	操作步驟
	Runbook v2.1.0
	SFHB-V2-{section}
	程序規格
	N/A
	Candidate門檻
	SRS non-normative
	Evidence_Refs區塊
	暫定建議值
	N/A
	ICT Registry Schema
	ICD
	SCHEMA-ICT-*
	熱插拔Schema [NEW]
	N/A
	SEM³ SGF報表
	ICD
	SCHEMA-SEM3-SGF-REPORT
	SGF完整Schema [NEW]
	N/A
	SEM³ MSC報表
	ICD
	SCHEMA-SEM3-MSC-REPORT
	MSC完整Schema [NEW]
	N/A
	SEM³ TVE報表
	ICD
	SCHEMA-SEM3-TVE-REPORT
	TVE完整Schema [NEW]
	N/A
	SEM³門檻數值
	Fitness
	LBP-E-SEM3-THRESHOLDS
	具體數值 [NEW]
	N/A
	SEM³ ADR
	ADR
	ADR-SEM3-01/02
	採用決策 [NEW]
	N/A
	Automation工件Schema
	ICD
	SCHEMA-AUTOMATION-*
	4種工件 [NEW]
	CR_OPEN
	Arbiter決策Schema
	ICD
	SCHEMA-ARBITER-*
	仲裁Schema [NEW]
	CR_OPEN
	Candidate治理
	SRS / Acceptance Map
	-
	H0-H8規則 [NEW]
	N/A
	________________


§1 Document Overview
§1.1 Purpose & Scope
[ANCHOR:ARCH-PURPOSE]
本ARCH描述Spartoi P1系統的架構設計，為開發/測試/審查/維護提供架構級視圖與接線指引。
範圍：
* 系統邊界與外部介面
* 15子系統分解與職責邊界
* 控制面三件套架構
* SF主鍵流程架構
* Agent/T0-T1雙模架構
* 關鍵約束與降級策略
* SEM³三Gate驗證架構 [ENHANCED]
* 5大架構構件定位 [NEW]
* ICT熱插拔機制 [NEW]
§1.2 Goals
[ANCHOR:ARCH-GOALS]
1. 提供架構級SSOT（Single Source of Truth for Architecture）
2. 支援SRS v7.0.0全量需求的架構落地
3. 確保架構可追溯（每個決策可回指到上游）
4. 提供AI/LLM可檢索的結構化架構知識
5. 整合SEM³三位一體語意治理體系 [NEW]
6. 落地H3-H7假說架構支撐 [NEW]
§1.3 Non-Goals
[ANCHOR:ARCH-NON-GOALS]
1. ❌ 定義需求（SSOT: SRS）
2. ❌ 定義Schema全文（SSOT: LBP-B）
3. ❌ 提供操作手冊（SSOT: Runbook）
4. ❌ 設定量化門檻（SSOT: SRS non-normative）
§1.4 Stakeholders
[ANCHOR:ARCH-STAKEHOLDERS]
Stakeholder
	關注點
	本ARCH提供
	開發者
	子系統邊界、介面契約
	§4子系統分解、Route-Out
	測試者
	可測試性、Gate位置
	§5 SF流程、控制面
	審查者
	追溯性、覆蓋率
	Route-Out Map、Conflict Ledger
	維護者
	降級路徑、Fail-Closed
	§6控制面、§8約束
	________________


§2 Architecture Framework (ISO 42010)
§2.1 Viewpoint Catalog
[ANCHOR:ARCH-VIEWPOINT-CATALOG]
Viewpoint
	Concerns
	Stakeholders
	對應View
	Context
	系統邊界、外部依賴
	所有
	§3.1
	Container
	子系統拓撲、通訊
	開發、測試
	§3.2
	Deployment
	部署節點、運行環境
	維運、安全
	§3.3
	Control
	控制面、降級路徑
	維護、風控
	§6
	Flow
	SF主鍵、資料流
	開發、測試
	§5
	Semantic
	SEM³驗證、語意保真
	品質、審計
	§6.7 [NEW]
	§2.2 View Index
[ANCHOR:ARCH-VIEW-INDEX]
View ID
	名稱
	Anchor
	描述
	V-CTX
	Context View
	ARCH-CONTEXT-VIEW
	系統與外部邊界
	V-CON
	Container View
	ARCH-CONTAINER-VIEW
	15子系統拓撲
	V-DEP
	Deployment View
	ARCH-DEPLOYMENT-VIEW
	部署架構
	V-FLW
	Flow View
	ARCH-SF-DATAFLOW
	SF資料流
	V-CTL
	Control View
	ARCH-FLAG-REGISTRY
	控制面架構
	V-SEM
	Semantic View
	ARCH-SEM3-COMPLETE
	SEM³三Gate [NEW]
	§2.3 Architecture Vocabulary
[ANCHOR:ARCH-VOCABULARY]
術語
	定義
	使用範圍
	CA-*
	Capability Area（子系統）
	15個子系統命名
	SF-xx
	Spartoi Flow節點
	SF-00~SF-31
	HITL
	Human-in-the-Loop
	SF-11決策門
	Gate
	流程關卡/驗證點
	定義於SRS
	Route-Out
	外導至其他SSOT
	ARCH邊界控制
	Fail-Closed
	失敗時採保守策略
	降級原則
	Candidate
	待驗證項
	遷移至CR_OPEN
	SEM³
	Semantic Equivalence & Mapping Triad
	SGF/MSC/TVE三Gate [NEW]
	SGF
	Source-Grounded Faithfulness
	來源對齊忠實度 [NEW]
	MSC
	Method-Semantics Conformance
	方法語義一致性 [NEW]
	TVE
	Translation-Validation Equivalence
	轉譯等價驗證 [NEW]
	attended-first
	優先人工監督策略
	架構級策略 [NEW]
	________________


§3 Architecture Views（最小視圖集）
§3.1 Context View（系統邊界）
[ANCHOR:ARCH-CONTEXT-VIEW]
系統邊界與外部實體
┌─────────────────────────────────────────────────────────────────────────┐
│                          EXTERNAL CONTEXT                                │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │                    SPARTOI P1 SYSTEM BOUNDARY                      │  │
│  │                                                                     │  │
│  │  ┌─────────────────────────────────────────────────────────────┐   │  │
│  │  │                    CA-UI (Single Entry)                      │   │  │
│  │  │            ↕ connects all 15 subsystems ↕                    │   │  │
│  │  └─────────────────────────────────────────────────────────────┘   │  │
│  │                                                                     │  │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐              │  │
│  │  │ CA-WRC   │ │CA-CORPUS │ │CA-DISTILL│ │ CA-DSL   │              │  │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘              │  │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐              │  │
│  │  │CA-METHOD │ │CA-BACKTEST│ │ CA-TA   │ │CA-SELECT │              │  │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘              │  │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐              │  │
│  │  │CA-TRANSLATE│ │CA-WATCH│ │CA-EXECUTE│ │CA-PERFORM│              │  │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘              │  │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐                           │  │
│  │  │CA-COLLAB │ │CA-GOVERN │ │CA-AGENT  │  SF-11: HITL Gate         │  │
│  │  └──────────┘ └──────────┘ └──────────┘  (not subsystem)          │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                          │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐               │
│  │  Local FS    │    │  LLM (Free)  │    │ WebTools-NA  │               │
│  │  (DuckDB)    │    │  Optional    │    │ Manual Paste │               │
│  └──────────────┘    └──────────────┘    └──────────────┘               │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘


外部實體信任邊界
外部實體
	信任等級
	互動類型
	信任邊界控制
	ARCH機制
	Operator (Human)
	HIGH
	HITL Decisions
	SF-11 Gate 強制人工確認
	§5.4
	Market Data Sources
	MEDIUM
	Read-Only
	資料品質Gate + Fail-Closed
	§4.3
	Broker API (XQ/XSAT)
	MEDIUM
	Execute-Only
	Contract驗證 + Kill Switch
	§4.12
	Local FS (DuckDB)
	HIGH
	CRUD
	本地優先、禁止人工搬運
	§3.3
	LLM (Free Tier)
	LOW
	Optional Assist
	白名單 + 結果需人工驗證
	§4.14
	WebTools-NA
	LOW
	Manual Paste
	WT-NA降級機制
	§3.4
	關鍵利益相關者
Stakeholder
	Concerns
	ARCH提供
	單人維運者
	全流程可控、風險管理
	SF主鍵流程、Kill Switch
	系統開發者
	邊界清晰、可測試性
	子系統分解、Interface Matrix
	審計者
	可追溯、可稽核
	Route-Out Map、Evidence Chain
	________________


§3.2 Container View（子系統拓撲）
[ANCHOR:ARCH-CONTAINER-VIEW]
15子系統容器圖
┌─────────────────────────────────────────────────────────────────────┐
│                     SPARTOI P1 CONTAINER VIEW                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │                    CA-UI (桌面軟體單一入口)                   │    │
│  │  REST API + WebSocket → All 15 Subsystems                   │    │
│  └─────────────────────────────────────────────────────────────┘    │
│           │              │              │              │             │
│           ▼              ▼              ▼              ▼             │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                    KNOWLEDGE PIPELINE                         │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐          │   │
│  │  │ CA-WRC  │→│CA-CORPUS│→│CA-DISTILL│→│ CA-DSL  │          │   │
│  │  │ 白名單   │  │ 語料庫  │  │ 蒸餾引擎 │  │純原語庫  │          │   │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────┘          │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                              │                                       │
│                              ▼                                       │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                    METHOD & BACKTEST                          │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐          │   │
│  │  │CA-METHOD│→│CA-BACKTEST│→│ CA-TA  │→│CA-SELECT│          │   │
│  │  │方法卡生成│  │ 回測模擬 │  │技術分析 │  │ 選股篩選 │          │   │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────┘          │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                              │                                       │
│                              ▼                                       │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                    TRADING PIPELINE                           │   │
│  │  ┌──────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐         │   │
│  │  │CA-TRANSLATE│→│CA-WATCH│→[SF-11 HITL]→│CA-EXECUTE│         │   │
│  │  │ XS/XQ轉譯 │  │盯盤監控 │  │(Gate)   │  │ 執行下單 │         │   │
│  │  └──────────┘  └─────────┘  └─────────┘  └─────────┘         │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                              │                                       │
│                              ▼                                       │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                    GOVERNANCE & OBSERVE                       │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐          │   │
│  │  │CA-PERFORM│  │CA-COLLAB│  │CA-GOVERN│  │CA-AGENT │          │   │
│  │  │績效分析 │  │多LLM協作│  │治理控制 │  │Agent模式│          │   │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────┘          │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌────────────────────────────────────────────────────────────┐     │
│  │  LOCAL STORAGE (DuckDB/SQLite) - 禁止人工搬運              │     │
│  │  /spartoi_flow/ (SSOT) │ /dayflow/ (Legacy Compat)         │     │
│  └────────────────────────────────────────────────────────────┘     │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘


§3.2.1 CA-UI Interface Matrix（14×5完整表格）
[ANCHOR:ARCH-CA-UI-INTERFACE-MATRIX]
CA-UI MUST 連接全部15子系統，作為使用者操作之單一入口。
子系統ID
	CA-UI介面類型
	操作範圍
	ICD引用
	Fail-Closed行為
	CA-WRC
	REST API
	教材上傳/查詢/週審觸發
	CONTRACT-UI-WRC-001
	上傳失敗→重試/告警
	CA-CORPUS
	REST API
	語料庫瀏覽/標註/匯入匯出
	CONTRACT-UI-CORPUS-001
	匯入失敗→原子回滾
	CA-DISTILL
	REST API
	蒸餾任務觸發/進度查詢
	CONTRACT-UI-DISTILL-001
	任務失敗→SEG Gate攔截
	CA-DSL
	REST API
	DSL編輯器/語法檢查/原語查詢
	CONTRACT-UI-DSL-001
	語法錯誤→阻斷儲存
	CA-METHOD
	REST API
	MethodCard編輯/版本管理/SEM³報告
	CONTRACT-UI-METHOD-001
	MSC失敗→禁止發布
	CA-BACKTEST
	REST API
	回測任務配置/執行/報告查看
	CONTRACT-UI-BACKTEST-001
	回測異常→Fail-Closed
	CA-TA
	REST API
	技術分析配置/信號查詢
	CONTRACT-UI-TA-001
	無信號→等待/告警
	CA-SELECT
	REST API
	選股條件配置/候選股查看
	CONTRACT-UI-SELECT-001
	選股失敗→空候選
	CA-TRANSLATE
	REST API
	XS/XQ轉譯觸發/TVE報告查看
	CONTRACT-UI-TRANSLATE-001
	TVE失敗→Radar-only
	CA-WATCH
	WebSocket+REST
	即時行情訂閱/盯盤面板/警報
	CONTRACT-UI-WATCH-001
	訂閱斷線→自動重連
	CA-EXECUTE
	REST API
	下單介面/訂單狀態/執行歷史
	CONTRACT-UI-EXECUTE-001
	下單失敗→Kill Switch
	CA-PERFORM
	REST API
	績效儀表板/報表匯出/基線比較
	CONTRACT-UI-PERFORM-001
	計算異常→顯示N/A
	CA-COLLAB
	REST+WebSocket
	Agent模式控制/計畫審核/審計日誌
	CONTRACT-UI-COLLAB-001
	Agent異常→強制NON_AGENT
	CA-GOVERN
	REST API
	Flag Registry操作/Degrade查看/Kill Switch
	CONTRACT-UI-GOVERN-001
	控制失敗→Fail-Safe
	Route-Out: UI Schema → LBP-B(ICD) [CONTRACT-UI-*]
________________


§3.2.6 Orchestrator Architecture
[ANCHOR:ARCH-ORCHESTRATOR] [NEW:PATCH-052]
架構定位：Orchestrator為流程編排器，負責SF-00到SF-17的流程控制。
在15子系統中的位置：
* 歸屬：CA-GOVERN轄下的獨立架構構件
* 職責：流程編排、狀態管理、異常路由
* 特性：attended模式，no-LLM-API（純規則驅動）
職責範圍：
職責
	說明
	約束
	流程啟動
	觸發SF-00 Preflight
	需滿足前置條件
	狀態追蹤
	維護各SF節點狀態
	單一真相源
	異常路由
	錯誤發生時路由到fallback
	Fail-Closed原則
	完成通知
	SF流程完成後通知CA-UI
	同步/非同步可配置
	約束：
* no-LLM-API：Orchestrator不調用LLM API，純規則驅動
* attended：預設attended模式，需人工確認關鍵節點
* Fail-Closed：任何異常導致流程暫停，等待人工介入
Route-Out：詳細狀態機見ICD [SCHEMA-ORCHESTRATOR-STATE]
________________


§3.2.7 Artifact Store Architecture
[ANCHOR:ARCH-ARTIFACT-STORE] [NEW:PATCH-053]
架構定位：Artifact Store為工件存放中心，實現SSOT + versioned策略。
在15子系統中的位置：
* 歸屬：CA-GOVERN轄下的獨立架構構件
* 職責：工件存放、版本管理、證據歸檔
* 特性：唯一真相源（SSOT）、版本化、可追溯
存放範圍：
工件類型
	路徑模式
	保留策略
	SF工件
	/artifacts/sf/{sf_id}/{run_id}/
	永久
	自動化工件
	/artifacts/automation/{run_id}/
	30天
	回測報告
	/artifacts/backtest/{run_id}/
	永久
	執行日誌
	/artifacts/execution/{date}/
	90天
	版本化策略：
* 每次寫入產生新版本（immutable）
* 版本ID = {artifact_id}:{timestamp}:{hash}
* 支援任意版本回溯
約束：
* SSOT：每類工件只有一個存放位置
* Immutable：工件一旦寫入不可修改，只能新增版本
* Traceable：每個工件都有evidence_ptr指向來源
Route-Out：詳細Schema見ICD [SCHEMA-ARTIFACT-STORE]
________________


§3.2.8 Validators Architecture
[ANCHOR:ARCH-VALIDATORS] [NEW:PATCH-054]
架構定位：Validators為驗證器群組，提供schema/format/consistency三層驗證。
在15子系統中的位置：
* 歸屬：CA-GOVERN轄下的獨立架構構件
* 職責：資料品質保障、格式驗證、一致性檢查
* 特性：Fail-Closed（驗證失敗即拒絕）
驗證層次：
層次
	驗證內容
	觸發點
	Schema驗證
	JSON Schema合規性
	工件寫入時
	Format驗證
	欄位格式正確性
	工件寫入時
	Consistency驗證
	跨工件一致性
	SF節點轉換時
	與Evals Runner關係：
* Validators：即時驗證，同步阻斷
* Evals Runner：回歸測試，非同步批次
* 分工：Validators處理單一工件，Evals Runner處理跨版本比對
約束：
* Fail-Closed：任何驗證失敗即拒絕該工件
* 可擴展：驗證規則以外掛形式載入
* 可追溯：驗證結果寫入Event Log
Route-Out：驗證規則定義見ICD [SCHEMA-VALIDATOR-RULES]
________________


§3.2.9 Evals Runner Architecture
[ANCHOR:ARCH-EVALS-RUNNER] [NEW:PATCH-012-R]
架構定位：Evals Runner為回歸測試執行器，支援LLM Factory穩定度驗證。
在15子系統中的位置：
* 歸屬：CA-GOVERN轄下的獨立架構構件
* 職責：回歸測試執行、跨版本比對、品質趨勢追蹤
與Validators關係：
構件
	驗證類型
	執行時機
	阻斷方式
	Validators
	即時驗證
	工件寫入時
	同步阻斷
	Evals Runner
	回歸測試
	版本發布前
	非同步批次
	協作流程：
[工件產生] → [Validators即時驗證] → [Artifact Store存放]
                                              ↓
                               [Evals Runner批次回歸]
                                              ↓
                               [regression_report.json]


四類回歸測試：
類別
	說明
	頻率
	Schema回歸
	新版Schema與舊版相容性
	每次Schema變更
	行為回歸
	同輸入產出相同結果
	每日
	效能回歸
	執行時間不劣化
	每週
	品質回歸
	品質指標不下降
	每版本
	約束：
* 非阻斷：回歸測試失敗發WARNING，不阻斷開發
* 可追溯：每次回歸結果存入Artifact Store
* 趨勢追蹤：歷史結果可做品質趨勢分析
Route-Out：
* 完整規格：ICD [SCHEMA-EVALS-RUNNER]
* 驗收條件：SRS §3.16 [SRS-V700-FR-EVALS]
________________


§3.2.10 Container View ASCII Summary
[ANCHOR:ARCH-CONTAINER-ASCII] [NEW:PATCH-065]
《增補升級方案v2》§4.3.1定義的關鍵構件ASCII架構圖。
┌─────────────────────────────────────────────────────────────────┐
│                   Spartoi P1 Container View                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │               ICT-0..7 Multi-LLM Factory                  │   │
│  ├──────────────────────────────────────────────────────────┤   │
│  │  ├─ Orchestrator (attended, no-LLM-API)                  │   │
│  │  │   └─ §3.2.6 [ANCHOR:ARCH-ORCHESTRATOR]                │   │
│  │  ├─ Artifact Store (SSOT, versioned)                     │   │
│  │  │   └─ §3.2.7 [ANCHOR:ARCH-ARTIFACT-STORE]              │   │
│  │  ├─ Validators (schema/format/consistency)               │   │
│  │  │   └─ §3.2.8 [ANCHOR:ARCH-VALIDATORS]                  │   │
│  │  ├─ Evals Runner (regression)                            │   │
│  │  │   └─ §3.2.9 [ANCHOR:ARCH-EVALS-RUNNER]                │   │
│  │  └─ Browser Automation Assistant (Playwright RPA-lite)   │   │
│  │      └─ §3.4 [ANCHOR:ARCH-AUTOMATION-ASSISTANT]          │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                      15 Subsystems                          │ │
│  │  CA-WRC | CA-CORPUS | CA-DISTILL | CA-METHOD | CA-DSL      │ │
│  │  CA-BACKTEST | CA-TA | CA-TRANSLATE | CA-WATCH | CA-EXECUTE│ │
│  │  CA-PERFORM | CA-GOVERN | CA-UI | CA-COLLAB | CA-AGENT     │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘


5關鍵構件在15子系統中的位置：
構件
	歸屬子系統
	架構錨點
	Orchestrator
	CA-GOVERN
	[ANCHOR:ARCH-ORCHESTRATOR]
	Artifact Store
	CA-GOVERN
	[ANCHOR:ARCH-ARTIFACT-STORE]
	Validators
	CA-GOVERN
	[ANCHOR:ARCH-VALIDATORS]
	Evals Runner
	CA-GOVERN
	[ANCHOR:ARCH-EVALS-RUNNER]
	Automation Assistant
	CA-UI
	[ANCHOR:ARCH-AUTOMATION-ASSISTANT]
	________________


§3.3 Deployment View（部署架構）
[ANCHOR:ARCH-DEPLOYMENT-VIEW]
部署拓撲
┌─────────────────────────────────────────────────────────────────┐
│                    DEPLOYMENT TOPOLOGY                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │               LOCAL WORKSTATION (單人維運)               │    │
│  │                                                          │    │
│  │  ┌────────────────────────────────────────────────┐     │    │
│  │  │           FLET DESKTOP APPLICATION              │     │    │
│  │  │              (CA-UI Entry Point)                │     │    │
│  │  └────────────────────────────────────────────────┘     │    │
│  │                         │                                │    │
│  │  ┌────────────────────────────────────────────────┐     │    │
│  │  │           PYTHON 3.13 RUNTIME                   │     │    │
│  │  │  ┌─────────┐ ┌─────────┐ ┌─────────┐           │     │    │
│  │  │  │ 15 CA-* │ │ SF Flow │ │ Control │           │     │    │
│  │  │  │Subsystems│ │ Engine  │ │ Plane   │           │     │    │
│  │  │  └─────────┘ └─────────┘ └─────────┘           │     │    │
│  │  └────────────────────────────────────────────────┘     │    │
│  │                         │                                │    │
│  │  ┌────────────────────────────────────────────────┐     │    │
│  │  │           LOCAL STORAGE                         │     │    │
│  │  │  ┌─────────────┐  ┌─────────────┐              │     │    │
│  │  │  │ DuckDB/SQLite│  │ File System │              │     │    │
│  │  │  │ (artifacts) │  │ (/spartoi_flow/)           │     │    │
│  │  │  └─────────────┘  └─────────────┘              │     │    │
│  │  └────────────────────────────────────────────────┘     │    │
│  │                                                          │    │
│  └─────────────────────────────────────────────────────────┘    │
│                              │                                   │
│              ┌───────────────┼───────────────┐                   │
│              │               │               │                   │
│              ▼               ▼               ▼                   │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐        │
│  │ WebTools-NA   │  │ LLM (Free)    │  │ Broker API    │        │
│  │ (Manual Paste)│  │ (Optional)    │  │ (XQ/XSAT)     │        │
│  │ Route: WT-NA  │  │ Route: WT-NA  │  │ Route: XQ-API │        │
│  └───────────────┘  └───────────────┘  └───────────────┘        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘


部署約束
約束項
	描述
	架構策略
	單機部署
	系統運行於單一工作站
	本地優先、無分散式依賴
	禁止人工搬運
	產物自動歸檔/索引/版本化
	Local DB + Control Plane Hooks
	No-Paid-LLM-API
	禁用付費AI API
	LLM可選、降級路徑存在
	三路由架構
	LOCAL/WT-NA/XQ-API
	主路徑LOCAL、執行路徑XQ-API
	Route-Out: 部署細節見 README/Infra文件
________________


§3.3.1 資料持久化架構（Data Persistence Architecture）
[ANCHOR:ARCH-DATA-PERSISTENCE]
本地資料庫分工：
資料庫類型
	用途
	使用子系統
	選型依據
	DuckDB
	OLAP分析查詢
	CA-TA, CA-SELECT, CA-PERFORM
	高效列式分析
	SQLite
	OLTP交易記錄
	CA-EXECUTE, CA-WATCH, CA-GOVERN
	輕量嵌入式
	子系統資料庫選擇規則：
子系統
	主資料庫
	備用方案
	Fail-Closed行為
	CA-WRC
	SQLite
	檔案系統
	資料庫不可用→使用檔案
	CA-CORPUS
	SQLite
	檔案系統
	同上
	CA-DISTILL
	SQLite
	檔案系統
	同上
	CA-BACKTEST
	DuckDB
	SQLite
	分析失敗→降級至SQLite
	CA-TA
	DuckDB
	SQLite
	同上
	CA-SELECT
	DuckDB
	SQLite
	同上
	CA-WATCH
	SQLite
	-
	必須可用
	CA-EXECUTE
	SQLite
	-
	必須可用（交易記錄）
	CA-PERFORM
	DuckDB
	SQLite
	分析失敗→降級
	CA-GOVERN
	SQLite
	-
	必須可用（治理記錄）
	資料持久化原則：
* 交易相關資料必須使用SQLite（保證ACID）
* 分析相關資料優先使用DuckDB（查詢效能）
* 所有工件必須同時寫入檔案系統（備援）
Route-Out：資料庫Schema見ICD [SCHEMA-DB-*]
§3.4 Browser Automation Assistant Architecture
[ANCHOR:ARCH-AUTOMATION-ASSISTANT] [NEW:PATCH-011-R]
3.4.1 架構定位
Browser Automation Assistant為獨立構件（非CA-UI附屬），支援WebTools-NA自動化（Playwright RPA-lite）。
在15子系統中的位置：
* 歸屬：CA-UI轄下的獨立架構構件
* 職責：提供H3可回放證據鏈的自動化執行與記錄能力
* 協作：與CA-GOVERN（審計）、CA-PERFORM（指標）、Artifact Store（存放）交互
3.4.2 必備工件（架構層）
工件
	格式
	職責
	Fail-Closed
	auto_trace.zip
	Playwright trace viewer格式
	完整執行追蹤，支援回放
	缺失→審計失敗
	auto_video.webm
	WebM視頻
	retain-on-failure策略
	失敗無視頻→人工補錄
	auto_screenshot/*.png
	PNG圖片
	關鍵決策點截圖，每10動作至少1張
	缺失→warning
	auto_action_log.jsonl
	JSONL
	動作日誌，對齊wtna_action_log
	缺失→審計失敗
	3.4.3 工件生命週期
階段
	產生者
	消費者
	存放位置
	產生
	Automation Assistant
	-
	/spartoi_flow/automation_traces/
	消費
	-
	CA-GOVERN（審計）、CA-UI（回放）
	-
	歸檔
	-
	Artifact Store
	/artifacts/automation/{run_id}/
	保留
	-
	-
	30天（可配置）
	3.4.4 模式切換架構（attended-first策略）
架構約束：
* attended-first原則：優先人工監督，自動化作為輔助
* attended模式：人工監督 + 自動化執行 + 即時確認
* unattended模式：全自動執行 + 事後審計
模式切換條件（架構級）：
切換方向
	前置條件
	驗證要求
	attended→unattended
	連續N次attended執行成功
	evidence_chain完整 + 人工簽核
	unattended→attended
	任一執行失敗/異常
	強制降級，無需條件
	Route-Out：切換條件數值見SRS §3.19 [SRS-V700-FR-AUTOMATION]
3.4.5 Fail-Closed掛鉤
異常類型
	事件代碼
	處置
	selector失敗
	DG-AUTO-01
	fallback手動WT-NA
	timeout超時
	DG-AUTO-01
	fallback手動WT-NA
	captcha/MFA
	DG-AUTO-02
	強制人工介入
	元素不可交互
	DG-AUTO-01
	fallback手動WT-NA
	3.4.6 Route-Out
目標
	錨點
	內容
	ICD
	[SCHEMA-AUTOMATION-TRACE]
	auto_trace.zip Schema
	ICD
	[SCHEMA-AUTOMATION-ACTIONLOG]
	auto_action_log.jsonl Schema
	SRS
	§3.19 [SRS-V700-FR-AUTOMATION]
	驗收條件
	Runbook
	[RUNBOOK-WTNA-FALLBACK]
	手動fallback步驟
	________________


§4 System Decomposition（15子系統SSOT）
§4.1 Subsystem Overview
[ANCHOR:ARCH-SUBSYSTEM-OVERVIEW]
子系統數量: 15（v6.0.0已刪除CA-FIREWALL；v6.0.0-patch-r3將CA-AGENT整併至CA-COLLAB）
子系統ID
	中文名稱
	職責域
	SF節點關聯
	CA-WRC
	白名單資源中心
	教材入庫/週審
	SF-01
	CA-CORPUS
	語料庫管理
	分塊/索引/多模態
	SF-02
	CA-DISTILL
	蒸餾引擎
	LLM蒸餾/SEG Gate
	SF-03
	CA-DSL
	純原語庫
	DSL原語/IR/MarketProfile SSOT
	SF-04
	CA-METHOD
	方法卡管理
	MethodCard/MSG Gate
	SF-05~06
	CA-BACKTEST
	回測引擎
	Walk-Forward/過擬合防線
	SF-07
	CA-TA
	技術分析
	技術指標/策略篩選
	SF-08
	CA-SELECT
	選股篩選
	TopK選擇/候選管理
	SF-08
	CA-TRANSLATE
	XS/XQ轉譯
	TVG Gate
	SF-09
	CA-WATCH
	盯盤監控
	信號產生/預警
	SF-10
	CA-EXECUTE
	執行下單
	訂單管理/Kill Switch
	SF-12~17
	CA-PERFORM
	績效分析
	雙跑道Fitness
	SF-31
	CA-COLLAB
	協作控制+Agent
	多LLM Factory/Agent雙模/Skills Registry
	-
	CA-UI
	使用者介面
	單一入口/全子系統連接/JobCard流轉
	-
	CA-GOVERN
	治理控制
	Control Plane/SEM³ Gate/三件套
	-
	不可回退項：
1. CA-FIREWALL已於v6.0.0永久刪除，原功能全面廢棄（依《Candidate處置規則_v2》）
2. CA-AGENT已於v6.0.0-patch-r3整併至CA-COLLAB，維持15子系統架構
________________


§4.1.1 技術棧與目錄結構
[ANCHOR:ARCH-PYTHON-CORE-DIRECTORY]
Python版本：3.13+
目錄結構（架構層）：
spartoi_p1/
├── core/                    # 核心處理
│   ├── distill/             # CA-DISTILL
│   ├── dsl/                 # CA-DSL
│   ├── method/              # CA-METHOD
│   ├── backtest/            # CA-BACKTEST
│   └── analytics/           # CA-TA, CA-SELECT, CA-PERFORM
├── trading/                 # 交易執行
│   ├── watch/               # CA-WATCH
│   ├── execute/             # CA-EXECUTE
│   └── translate/           # CA-TRANSLATE
├── knowledge/               # 知識管理
│   ├── wrc/                 # CA-WRC
│   └── corpus/              # CA-CORPUS
├── collaboration/           # 協作
│   └── collab/              # CA-COLLAB
├── ui/                      # 使用者介面
│   └── desktop/             # CA-UI
└── governance/              # 治理
    └── govern/              # CA-GOVERN


子系統與目錄對應表：
子系統ID
	目錄路徑
	說明
	CA-WRC
	knowledge/wrc/
	教材蒐集
	CA-CORPUS
	knowledge/corpus/
	語料庫管理
	CA-DISTILL
	core/distill/
	LLM蒸餾引擎
	CA-DSL
	core/dsl/
	原語庫
	CA-METHOD
	core/method/
	方法卡管理
	CA-BACKTEST
	core/backtest/
	回測引擎
	CA-TA
	core/analytics/
	技術分析
	CA-SELECT
	core/analytics/
	選股
	CA-TRANSLATE
	trading/translate/
	翻譯器
	CA-WATCH
	trading/watch/
	盯盤
	CA-EXECUTE
	trading/execute/
	執行
	CA-PERFORM
	core/analytics/
	績效分析
	CA-COLLAB
	collaboration/collab/
	多LLM協作
	CA-UI
	ui/desktop/
	桌面UI
	CA-GOVERN
	governance/govern/
	治理
	Route-Out：完整技術棧規範見README v3.0.0
§4.2 CA-WRC
[ANCHOR:ARCH-CA-WRC]
職責：管理白名單教材資源，執行週審入庫。
架構位置：Knowledge Pipeline入口
關鍵交互：
* 輸入：外部教材（PDF/MD/Video）
* 輸出：corpus_index.jsonl → CA-CORPUS
* Gate：週審Gate（每週觸發）
Route-Out：詳細規格見ICD [CONTRACT-WRC-*]
________________


§4.3 CA-CORPUS
[ANCHOR:ARCH-CA-CORPUS]
職責：語料庫管理，包含分塊/索引/多模態處理。
§4.3.1 Canonical Corpus Manifest Architecture
[ANCHOR:ARCH-CORPUS-MANIFEST] [NEW:PATCH-R3-009]
架構定位：canonical_corpus_manifest.json為語料庫唯一清單SSOT。
管理責任：
* 維護者：CA-WRC（入庫時新增/更新）
* 消費者：CA-CORPUS（索引時讀取）、CA-DISTILL（蒸餾時驗證）
* 更新觸發：週審Gate通過後自動更新
最小欄位（架構層）：
{
  "corpus_id": "string (UUID)",
  "version": "string (semver)",
  "sources": ["source_item[]"],
  "total_document_count": "integer",
  "last_updated": "ISO8601"
}


Route-Out：完整Schema見ICD [SCHEMA-CORPUS-MANIFEST]
§4.3.2 Provenance Validation Architecture
[ANCHOR:ARCH-CORPUS-PROVENANCE] [NEW:PATCH-R3-009]
驗證時機：CA-WRC入庫時（Gate前置檢查）
架構約束：
* 入庫教材MUST帶provenance（source_id, author, date, hash）
* 缺provenance MUST拒絕入庫 → corpus_rejection_log.json
驗證器位置：CA-WRC內部Provenance Validator
Fail-Closed：provenance缺失→阻斷入庫→產生rejection_log
Route-Out：rejection_log Schema見ICD [SCHEMA-CORPUS-REJECTION]
§4.3.3 Whitelist Recall Architecture
[ANCHOR:ARCH-CORPUS-RECALL] [NEW:PATCH-R3-009]
觸發方式：週期性（週審Gate觸發）+ 手動（CA-UI發起）
架構流程：
[週審觸發] → [CA-WRC Recall Module] → [掃描whitelist更新] 
           → [增量同步] → [觸發重索引] → [更新manifest]


策略：
* 增量優先：僅同步變更內容
* 全量回退：連續3次增量失敗→全量同步
Route-Out：Recall規則見ICD [SCHEMA-CORPUS-RECALL-CONFIG]
§4.2.5 Multi-Modal Pipeline Architecture
[ANCHOR:ARCH-MULTIMODAL-PIPELINE] [NEW:PATCH-024-R]
P1-ICRU §5.1.4定義的4條多模態路徑架構。
4路徑架構：
路徑
	輸入類型
	處理子系統
	輸出形式
	架構差異
	文字路徑
	純文字PDF/MD
	CA-CORPUS
	chunks.jsonl
	標準RAG流程
	表格路徑
	Excel/CSV/表格
	CA-CORPUS + Table Parser
	structured_data.jsonl
	需結構化抽取
	圖表路徑
	圖片/圖表
	CA-CORPUS + Vision Model
	figure_desc.jsonl
	需視覺理解
	影片路徑
	視頻教學
	CA-CORPUS + Video Transcriber
	video_chunks.jsonl
	需ASR+OCR
	資料流架構：
[原始教材]
    |
    +-- [文字路徑] → Text Chunker → chunks.jsonl
    |
    +-- [表格路徑] → Table Parser → structured_data.jsonl
    |                                              ↓
    +-- [圖表路徑] → Vision Model → figure_desc.jsonl
    |                                              ↓
    +-- [影片路徑] → Transcriber → video_chunks.jsonl
    |
    v
[CA-DISTILL] ← 整合4路徑輸出 → [evidence_card.json]


路徑選擇邏輯：
* 由CA-CORPUS根據輸入MIME type自動路由
* 混合文件（如帶表格的PDF）會拆分到多路徑並行處理
* 最終在CA-DISTILL整合所有路徑輸出
Route-Out：路徑選擇規則見ICD [SCHEMA-MULTIMODAL-ROUTER]
§4.2.6 Historical Data Architecture
[ANCHOR:ARCH-HISTORICAL-DATA]
歷史資料準備的架構支撐。
職責：管理歷史行情/財報/新聞資料。
Route-Out：資料格式見ICD [SCHEMA-HISTORICAL-DATA]
________________


§4.4 CA-DISTILL
[ANCHOR:ARCH-CA-DISTILL]
職責：LLM蒸餾引擎，產出technique_spec與evidence_card。
架構位置：Knowledge Pipeline核心
SEM³關聯：SEG Gate執行點
Route-Out：蒸餾規格見ICD [CONTRACT-DISTILL-*]
________________


§4.5 CA-DSL
[ANCHOR:ARCH-CA-DSL]
職責：管理純原語庫，支援DSL編輯與IR生成。
CA-DSL純原語政策
[ANCHOR:ARCH-CA-DSL-PURITY]
正面清單（允許原語）：
1. 時間過濾原語（Time Filter）
2. 價量過濾原語（Price/Volume Filter）
3. 技術指標原語（Technical Indicator）
4. 信號原語（Signal Primitive）
5. 條件組合原語（Condition Combinator）
6. 風控原語（Risk Control）
7. 倉位原語（Position Sizing）
8. 執行原語（Execution）
9. 報告原語（Report）
10. 警報原語（Alert）
11. 日誌原語（Logging）
12. 資料存取原語（Data Access）
13. 狀態管理原語（State Management）
14. 同步原語（Sync）
15. 驗證原語（Validation）
負面清單（禁止）：
1. 直接LLM API調用
2. 網路請求（除白名單）
3. 任意代碼執行
4. 未定義原語
5. 跨邊界資料存取
6. 非授權檔案操作
Route-Out：Lint規則定義見ICD [SCHEMA-DSL-LINT-RULES]
§4.5.2 MarketProfile SSOT Architecture
[ANCHOR:ARCH-MARKETPROFILE-SSOT] [NEW:PATCH-R3-004]
架構定位：market_profile.json為市場常數唯一來源（SSOT）。
管理責任：
* SSOT位置：CA-DSL管轄（/spartoi_flow/config/market_profile.json）
* 更新者：CA-GOVERN（依據交易所公告）
* 消費者：CA-METHOD、CA-BACKTEST、CA-WATCH、CA-EXECUTE
最小欄位（架構層）：
{
  "market_profile_id": "string (UUID)",
  "version": "string (semver)",
  "market_code": "TWSE",
  "trading_hours": {"open": "09:00", "close": "13:30"},
  "tick_size_rules": ["tick_rule[]"],
  "price_limit_pct": "number",
  "lot_size": "integer",
  "last_updated": "ISO8601"
}


架構約束：
* MethodCard MUST引用market_profile_id，禁止硬編碼市場常數
* 版本綁定：MethodCard.market_profile_ref → MarketProfile.version
Route-Out：完整Schema見ICD [SCHEMA-MARKETPROFILE]
§4.5.3 SessionPolicy Architecture
[ANCHOR:ARCH-SESSIONPOLICY] [NEW:PATCH-R3-004]
架構定位：session_policy.json定義交易時段策略。
最小欄位（架構層）：
{
  "policy_id": "string (UUID)",
  "phases": [
    {"phase_id": "PRE_OPEN", "start": "08:30", "end": "09:00", "constraints": []},
    {"phase_id": "OPEN", "start": "09:00", "end": "13:25", "constraints": []},
    {"phase_id": "CLOSE", "start": "13:25", "end": "13:30", "constraints": []}
  ]
}


與時間窗約束關係：
* SessionPolicy.phases為§8.4時間窗不變量的執行參數來源
* CA-WATCH/CA-EXECUTE依據SessionPolicy檢查時段合規性
Route-Out：完整Schema見ICD [SCHEMA-SESSIONPOLICY]
§4.5.4 MarketProfile Parity Gate Architecture
[ANCHOR:ARCH-MARKETPROFILE-PARITY] [NEW:PATCH-R3-004]
Gate定義：確保Backtest/Watch/Execute使用同一market_profile版本。
檢查點：
1. CA-BACKTEST啟動時：記錄market_profile_hash
2. CA-WATCH啟動時：比對market_profile_hash
3. CA-EXECUTE啟動時：比對market_profile_hash
Fail-Closed：hash不一致→BLOCK_EXECUTE + 警告日誌
Route-Out：Gate定義見SRS [SRS-V700-GATE-MARKETPROFILE-PARITY]
________________


§4.6 CA-METHOD
[ANCHOR:ARCH-CA-METHOD]
職責：方法卡生成與管理，包含版本控制。
SEM³關聯：MSG Gate執行點
Route-Out：MethodCard Schema見ICD [SCHEMA-METHODCARD]
________________


§4.7 CA-BACKTEST
[ANCHOR:ARCH-CA-BACKTEST]
職責：回測引擎，包含Walk-Forward與過擬合防線。
§4.7.5 Overfitting Defense Architecture
[ANCHOR:ARCH-OVERFITTING-DEFENSE] [NEW:PATCH-025-R]
P1-ICRU §5.2.3定義的4大過擬合防線架構約束。
4大防線架構：
防線
	全稱
	職責
	實現子系統
	Walk-Forward
	Walk-Forward Validation
	時序驗證，防止未來資訊洩漏
	CA-BACKTEST
	PBO
	Probability of Backtest Overfitting
	量化過擬合概率
	CA-BACKTEST
	CSCV
	Combinatorial Symmetric Cross-Validation
	組合交叉驗證
	CA-BACKTEST
	DSR
	Deflated Sharpe Ratio
	去膨脹夏普比，校正多重比較
	CA-PERFORM
	架構約束聲明：
約束
	說明
	Fail-Closed
	Walk-Forward強制
	所有回測必須使用Walk-Forward
	非Walk-Forward→拒絕結果
	PBO門檻
	PBO必須在可接受範圍
	PBO過高→warning
	CSCV驗證
	跨摺驗證一致性
	不一致→warning
	DSR校正
	報告必須包含DSR
	無DSR→結果不完整
	防線執行流程：
[回測執行] → [Walk-Forward驗證] → [PBO計算] → [CSCV驗證]
                                                    ↓
                               [DSR校正] → [backtest_report.json]


Route-Out：
* 防線細節：SRS §3.10 [SRS-V700-FR-BACKTEST]
* 門檻數值：Fitness [LBP-E-OVERFITTING-THRESHOLDS]
________________


§4.8 CA-TA
[ANCHOR:ARCH-CA-TA]
職責：技術分析引擎，產出技術指標與策略篩選。
Route-Out：TA規格見ICD [CONTRACT-TA-*]
________________


§4.9 CA-SELECT
[ANCHOR:ARCH-CA-SELECT]
職責：選股篩選，TopK選擇與候選管理。
Route-Out：選股規格見ICD [CONTRACT-SELECT-*]
________________


§4.10 CA-TRANSLATE
[ANCHOR:ARCH-CA-TRANSLATE]
職責：XS/XQ轉譯，產出可執行腳本。
SEM³關聯：TVG Gate執行點
Route-Out：轉譯規格見ICD [CONTRACT-TRANSLATE-*]
________________


§4.11 CA-WATCH
[ANCHOR:ARCH-CA-WATCH]
職責：盯盤監控，信號產生與預警。
時間窗約束關聯：見§8.4 [ANCHOR:ARCH-TIME-WINDOW-CONSTRAINTS]
Route-Out：盯盤規格見ICD [CONTRACT-WATCH-*]
________________


§4.12 CA-EXECUTE
[ANCHOR:ARCH-CA-EXECUTE]
職責：執行下單，訂單管理與Kill Switch。
時間窗約束關聯：見§8.4 [ANCHOR:ARCH-TIME-WINDOW-CONSTRAINTS]
Route-Out：執行規格見ICD [CONTRACT-EXECUTE-*]
________________


§4.13 CA-PERFORM
[ANCHOR:ARCH-CA-PERFORM]
職責：績效分析與Fitness驗證。
§4.15 CA-PERFORM Subsystem (Enhanced with Dual-Track)
[ANCHOR:ARCH-CA-PERFORM-DUALTRACK] [NEW:PATCH-057]
子系統職責：CA-PERFORM負責績效追蹤與Fitness驗證，支援H6「Fitness雙跑道」架構。
雙跑道架構：
跑道
	職責
	指標類型
	Track-A: 策略績效
	交易策略的實際表現
	勝率、報酬、夏普比等
	Track-B: 工程可靠度
	系統運行的可靠性
	正常運行、資料完整、流程成功、驗證通過
	四項工程可靠度指標架構：
指標
	說明
	資料來源
	計算位置
	報表輸出
	uptime_rate
	系統正常運行時間比例
	CA-GOVERN Event Log
	CA-PERFORM Metrics Engine
	/reports/fitness/reliability.json
	data_completeness
	資料完整性比例
	Validators驗證結果
	CA-PERFORM Metrics Engine
	/reports/fitness/reliability.json
	pipeline_success_rate
	流程成功執行比例
	Orchestrator狀態紀錄
	CA-PERFORM Metrics Engine
	/reports/fitness/reliability.json
	validation_pass_rate
	驗證通過比例
	SEM³ Gate結果
	CA-PERFORM Metrics Engine
	/reports/fitness/reliability.json
	§4.13.1 Track-A Five Measurable Goals Architecture
[ANCHOR:ARCH-CA-PERFORM-TRACKA] [NEW:PATCH-R3-010 對應 SRS §2.2.1]
五項可量測目標架構（對齊SRS-MEAS-001~005）：
SRS需求
	指標名稱
	計算公式
	資料來源
	報表輸出
	SRS-MEAS-001
	success_rate
	獲利交易數/總交易數
	CA-EXECUTE執行紀錄
	/reports/fitness/strategy.json
	SRS-MEAS-002
	profit_ratio
	總獲利/總虧損
	CA-EXECUTE執行紀錄
	/reports/fitness/strategy.json
	SRS-MEAS-003
	risk_ratio
	實際風險/預期風險
	CA-METHOD RiskCard
	/reports/fitness/strategy.json
	SRS-MEAS-004
	execution_efficiency
	成功執行時間/預期時間
	Orchestrator紀錄
	/reports/fitness/strategy.json
	SRS-MEAS-005
	semantic_fidelity
	SEM³ SGF Gate分數
	SEG Gate結果
	/reports/fitness/strategy.json
	指標計算位置：CA-PERFORM Metrics Engine
指標消費者：
* CA-UI：績效儀表板展示
* CA-GOVERN：閾值監控與告警
指標聚合週期：
* 即時：每筆交易後更新
* 日報：每日收盤後彙總
* 週報：每週五收盤後彙總
§4.13.2 Metrics Collection & Aggregation Architecture
[ANCHOR:ARCH-CA-PERFORM-METRICS] [NEW:PATCH-R3-010]
資料收集架構：
[CA-EXECUTE] → execution_record.json → [CA-PERFORM Collector]
[CA-METHOD] → risk_card.json → [CA-PERFORM Collector]
[CA-GOVERN] → sem3_report.json → [CA-PERFORM Collector]
[Orchestrator] → pipeline_log.json → [CA-PERFORM Collector]
           ↓
    [Metrics Engine]
           ↓
[Track-A Report] + [Track-B Report] → [Artifact Store]


Route-Out：Metrics Schema見ICD [SCHEMA-PERFORMANCE-METRICS]
雙跑道資料流：
[各子系統] → [Event Log] → [CA-PERFORM Metrics Engine]
                                    ↓
              [Track-A Metrics] + [Track-B Metrics]
                                    ↓
                     [/reports/fitness/*.json]
                                    ↓
              [CA-UI Dashboard] + [CA-GOVERN Alerts]


Route-Out：
* Fitness完整定義：[LBP-E-DUAL-TRACK]
* 報表Schema：ICD [SCHEMA-FITNESS-REPORT]
* 驗收條件：SRS §3.15 [SRS-V700-FR-FITNESS]
________________


§4.14 CA-COLLAB (含Agent模式)
[ANCHOR:ARCH-CA-COLLAB] [MERGED:CA-AGENT via PATCH-R3-SUB]
職責：多LLM協作控制 + Agent模式管理。
§4.14.1 Multi-LLM Collaboration Architecture
協作模式：
* 盲抽象（Blind Abstraction）
* 交叉審（Cross Review）
* 針對性整合（Targeted Integration）
Route-Out：協作規格見ICD [CONTRACT-COLLAB-*]
§4.14.2 Agent Extension Slot (AES) Architecture
[ANCHOR:ARCH-CA-COLLAB-AES] [NEW:PATCH-R3-002 對應 SRS-AGENT-001]
架構定位：AES為Agent能力擴展的標準插槽。
AES結構：
{
  "slot_id": "string (UUID)",
  "capability_type": "enum (SEARCH/SUMMARIZE/TRANSLATE/ANALYZE)",
  "binding": {"skill_id": "string", "version": "string"},
  "constraints": {"max_tokens": "integer", "timeout_ms": "integer"}
}


Route-Out：AES Schema見ICD [SCHEMA-AGENT-AES]
§4.14.3 Agent Three-Policy Card Architecture
[ANCHOR:ARCH-CA-COLLAB-POLICY] [NEW:PATCH-R3-002 對應 SRS-AGENT-002]
三張Policy卡：
Policy卡
	職責
	存放位置
	AgentPolicy
	Agent行為總約束
	/spartoi_flow/agent/agent_policy.yaml
	ToolPolicy
	工具使用約束
	/spartoi_flow/agent/tool_policy.yaml
	ApprovalPolicy
	審批流程約束
	/spartoi_flow/agent/approval_policy.yaml
	加載機制：CA-COLLAB Agent Controller啟動時載入三卡並驗證
變更流程：Policy卡變更需CA-GOVERN審批Gate通過
Route-Out：Policy Schema見ICD [SCHEMA-AGENT-POLICY]
§4.14.4 Agent Mandatory Artifacts Architecture
[ANCHOR:ARCH-CA-COLLAB-ARTIFACTS] [NEW:PATCH-R3-002 對應 SRS-AGENT-003]
5個必交付工件：
工件
	產生位置
	存放路徑
	agent_session_log.json
	CA-COLLAB
	/artifacts/agent/sessions/
	agent_action_trace.json
	CA-COLLAB
	/artifacts/agent/traces/
	agent_decision_record.json
	CA-COLLAB
	/artifacts/agent/decisions/
	agent_approval_log.json
	CA-COLLAB
	/artifacts/agent/approvals/
	agent_budget_report.json
	CA-COLLAB
	/artifacts/agent/budgets/
	生命週期：Session結束→工件落盤→Artifact Store歸檔
Route-Out：工件Schema見ICD [SCHEMA-AGENT-ARTIFACTS]
§4.14.5 Agent Guardrails Architecture
[ANCHOR:ARCH-CA-COLLAB-GUARDRAILS] [UPDATED:PATCH-R3-002 對應 SRS-AGENT-004]
禁止清單（4項，CR_OPEN_PTR待SRS授權）：
禁止項
	說明
	CR_OPEN
	GUI自動化
	禁止Agent執行GUI操作
	CR_OPEN:SRS-AGENT-001
	直接交易
	禁止Agent直接下單
	CR_OPEN:SRS-AGENT-002
	非白名單網路
	禁止非白名單網路存取
	CR_OPEN:SRS-AGENT-003
	寫入SSOT
	禁止Agent直接寫入SSOT
	CR_OPEN:SRS-AGENT-004
	§4.14.6 Mode Equivalence Test Architecture
[ANCHOR:ARCH-CA-COLLAB-EQUIV] [NEW:PATCH-R3-002 對應 SRS-AGENT-005]
測試目的：確保Agent模式與非Agent模式產出一致。
架構流程：
[相同輸入] → [NON_AGENT執行] → [結果A]
           → [AGENT_ASSIST執行] → [結果B]
           → [Equivalence Checker] → [差異報告]


檢查點：CA-GOVERN Accept Gate前執行
Route-Out：測試規格見ICD [SCHEMA-AGENT-EQUIV-TEST]
§4.14.7 Budget/Loop Guard Architecture
[ANCHOR:ARCH-CA-COLLAB-BUDGET] [NEW:PATCH-R3-002 對應 SRS-AGENT-006]
預算追蹤機制：
* max_budget_per_session：單次session最大Token消耗
* 追蹤器：CA-COLLAB Budget Tracker
* 超限行為：自動終止session + 產生budget_exceeded事件
迴圈檢測機制：
* max_iterations_per_task：單任務最大迴圈次數
* 檢測器：CA-COLLAB Loop Detector
* 超限行為：強制跳出 + 產生loop_detected事件
Route-Out：Guard Schema見ICD [SCHEMA-AGENT-GUARDS]
§4.14.8 ACML Maturity Levels Architecture
[ANCHOR:ARCH-CA-COLLAB-ACML] [NEW:PATCH-R3-002 對應 SRS-AGENT-007]
四個成熟度等級：
Level
	名稱
	能力範圍
	切換條件
	ACML-0
	無Agent
	完全禁用Agent
	預設
	ACML-1
	輔助
	僅SEARCH/SUMMARIZE
	人工核准
	ACML-2
	進階
	+TRANSLATE/ANALYZE
	連續N次成功
	ACML-3
	完整
	全能力
	治理團隊核准
	等級控制架構：
* 控制點：CA-GOVERN acml_level旗標
* 切換約束：只能逐級升降，不可跳級
Route-Out：ACML規格見SRS [SRS-V700-AGENT-ACML]
§4.14.9 HITL Checkpoint Persistence Architecture
[ANCHOR:ARCH-CA-COLLAB-CHECKPOINT] [NEW:PATCH-R3-002 對應 SRS-AGENT-008]
Checkpoint記錄機制：
* 記錄位置：hitl_checkpoint_log.json
* 記錄時機：每個HITL決策點
最小欄位（架構層）：
{
  "checkpoint_id": "string (UUID)",
  "session_id": "string",
  "decision_point": "string",
  "human_action": "APPROVE|REJECT|MODIFY",
  "timestamp": "ISO8601",
  "evidence_ptr": "string"
}


回放架構：CA-UI Replay Module讀取checkpoint_log實現回放
Route-Out：Checkpoint Schema見ICD [SCHEMA-AGENT-CHECKPOINT]
§4.14.10 Agent Mode Switch
[ANCHOR:ARCH-AGENT-MODE]
雙模定義：
模式
	代碼
	說明
	NON_AGENT
	0
	傳統手動模式（預設）
	AGENT_ASSIST
	1
	AI輔助模式
	切換觸發器：
觸發類型
	條件
	動作
	啟用Agent
	enable_agent_mode=true + 人工確認
	NON_AGENT→AGENT_ASSIST
	停用Agent
	人工停用/異常觸發
	AGENT_ASSIST→NON_AGENT
	切換約束：
* 切換需原子事務
* 切換記錄寫入審計日誌
* 異常時自動回退NON_AGENT
§4.14.11 Skills Registry Slot
[ANCHOR:ARCH-SKILLS-REGISTRY]
Skills定義（架構層）：
Skill ID
	能力
	約束
	SKILL_SEARCH
	資訊檢索
	白名單來源
	SKILL_SUMMARIZE
	摘要生成
	長度限制
	SKILL_TRANSLATE
	語言轉換
	語言對限制
	SKILL_ANALYZE
	資料分析
	輸出格式限制
	Route-Out：Skills完整定義見ICD [SCHEMA-AGENT-SKILLS]
________________


§4.15 CA-UI
§4.15.0 CA-UI核心功能清單（Core Functions）
[ANCHOR:ARCH-CA-UI-CORE-FUNCTIONS]
CA-UI 5大主要功能：
功能
	說明
	關聯子系統
	Fail-Closed行為
	即時狀態展示
	顯示系統/子系統/SF節點即時狀態
	全部
	狀態不明→顯示WARNING
	HITL確認介面
	提供人工確認候選→訊號的介面
	CA-GOVERN, CA-EXECUTE
	確認超時→Fail-Closed
	Kill Switch控制
	一鍵觸發/確認/恢復Kill Switch
	CA-GOVERN
	必須可用
	日誌流監控
	顯示系統事件/錯誤/警告日誌
	CA-GOVERN
	日誌斷流→告警
	WT-NA精靈
	輔助WT-NA協作模式的提示詞複製/貼上
	CA-COLLAB
	精靈失敗→手動模式
	操作範圍矩陣：
功能類別
	觀測
	配置
	觸發
	回放
	匯出
	知識管線
	✅
	✅
	✅
	✅
	✅
	交易執行
	✅
	⚠️
	⚠️
	✅
	✅
	控制面
	✅
	✅
	✅
	✅
	✅
	Agent協作
	✅
	✅
	✅
	✅
	✅
	⚠️ = 需HITL確認
Route-Out：UI詳細規格見ICD [CONTRACT-UI-*]
[ANCHOR:ARCH-CA-UI]
職責：使用者介面，單一入口連接全部15子系統。
介面矩陣：見§3.2.1 [ANCHOR:ARCH-CA-UI-INTERFACE-MATRIX]
§4.15.1 Decision Isolation Architecture
[ANCHOR:ARCH-CA-UI-ISOLATION] [NEW:PATCH-R3-005]
架構約束：UI不得產生買/賣/加碼/清倉決策。
決策產生位置明確標示：
決策類型
	產生子系統
	UI角色
	買入信號
	CA-WATCH
	展示
	賣出信號
	CA-WATCH
	展示
	倉位調整
	CA-METHOD
	展示
	清倉決策
	SF-11 (HITL)
	確認輸入
	Only-Display架構約束：
* CA-UI MUST NOT 含有任何交易邏輯
* CA-UI僅接收決策結果並展示
* 人工介入僅透過SF-11 HITL Gate
§4.15.2 JobCard Flow Architecture
[ANCHOR:ARCH-CA-UI-JOBCARD] [NEW:PATCH-R3-005]
JobCard流轉架構：
[使用者] ← 上傳 → [CA-UI]
              ↓ 解析/驗證
         [job_card.json]
              ↓ 觸發
         [Orchestrator] → [Pipeline執行]
              ↓ 結果
         [CA-UI展示執行結果]


架構元件：
* JobCard Parser：CA-UI內部，負責解析job_card.json
* JobCard Validator：CA-GOVERN Validators調用
* Result Display：CA-UI Result Panel
Route-Out：JobCard Schema見ICD [SCHEMA-JOBCARD]
§4.15.3 Capability Coverage Architecture
[ANCHOR:ARCH-CA-UI-CAPABILITY] [NEW:PATCH-R3-005]
能力註冊架構：
* capability_registry.json位置：CA-GOVERN管轄
* ui_capability_matrix.json位置：CA-UI管轄
* 維護者：CA-GOVERN（registry）/ CA-UI（matrix）
覆蓋驗證機制：
* 驗證時機：CA-UI啟動時
* 驗證邏輯：ui_capability_matrix對capability_registry形成100%映射
* 驗證失敗：UI啟動警告 + 記錄capability_gap_log
Route-Out：Capability Schema見ICD [SCHEMA-UI-CAPABILITY]
§4.15.4 Replay Architecture
[ANCHOR:ARCH-CA-UI-REPLAY] [NEW:PATCH-R3-005]
回放架構：
* 回放入口：CA-UI Replay Panel
* 資料來源：Artifact Store (traces, decisions, events)
* 回放模式：Step-by-Step / Fast-Forward / Jump-to-Point
與Automation Assistant整合：
* 讀取auto_trace.zip回放WebTools-NA操作
* 讀取auto_video.webm視覺化回放
Route-Out：Replay規格見ICD [CONTRACT-UI-REPLAY]
Route-Out：UI規格見ICD [CONTRACT-UI-*]
________________


§4.16 CA-GOVERN
[ANCHOR:ARCH-CA-GOVERN]
職責：治理控制，包含Control Plane與SEM³ Gate執行。
關鍵構件歸屬：
* Orchestrator [ANCHOR:ARCH-ORCHESTRATOR]
* Artifact Store [ANCHOR:ARCH-ARTIFACT-STORE]
* Validators [ANCHOR:ARCH-VALIDATORS]
* Evals Runner [ANCHOR:ARCH-EVALS-RUNNER]
SEM³ Gate執行：見§6.7 [ANCHOR:ARCH-SEM3-COMPLETE]
Route-Out：治理規格見ICD [CONTRACT-GOVERN-*]
________________


§4.17 LLM Factory Arbiter Architecture
[ANCHOR:ARCH-ARBITER] [NEW:PATCH-055] [RENUMBERED from §4.18 via PATCH-R3-SUB]
架構定位：Arbiter Module為多模型仲裁器，實現H7「多模型工廠仲裁規則」。
在15子系統中的位置：
* 歸屬：CA-DISTILL轄下的獨立架構構件（LLM Factory一部分）
* 職責：多LLM輸出仲裁、品質評估、最終選擇
* 特性：三角角色仲裁（Producer/Critic/Judge）
§4.14.1.1 三角角色仲裁約束（Arbitration Constraints）
[ANCHOR:ARCH-ARBITER-CONSTRAINTS]
三角角色（Producer/Verifier/Arbiter）架構約束：
禁止事項（MUST NOT）：
* ❌ 禁止加入審批流（Approval Flow）
* ❌ 禁止加入會議流（Meeting Flow）
* ❌ 禁止加入簽核Gate（Sign-off Gate）
* ❌ 禁止Arbiter成為交易決策者（Arbiter僅裁決不執行）
允許事項（MAY）：
* ✅ 定義輸入/輸出契約
* ✅ 定義仲裁規則（Arbiter Rules）
* ✅ 記錄仲裁決策（arbiter_decision.json）
架構原則（H7假說「減法」原則）：
* 三角協作模式以最小化人工介入為目標
* 任何新增治理流程必須有明確的failure_cost證據
* 預設拒絕新增審批步驟
Arbiter決策工件：
工件
	欄位
	Route-Out
	arbiter_decision.json
	decision_id, producer_output, verifier_verdict, arbiter_ruling, timestamp
	ICD [SCHEMA-ARBITER-DECISION]
	Route-Out：Arbiter詳細規格見ADR-LLM-ARBITER
三角角色架構：
角色
	職責
	輸出
	Producer
	產出候選內容
	candidate_outputs[]
	Critic
	評估候選品質
	criticism_scores[]
	Judge
	仲裁最終選擇
	final_selection + reasoning
	仲裁規則SSOT位置：
內容
	位置
	格式
	規則定義
	/spartoi_flow/llm_factory/arbiter_rules.yaml
	YAML配置
	執行器
	CA-DISTILL內部
	Python模組
	決策紀錄
	Artifact Store
	arbiter_decision.jsonl
	Judge結構化決策Schema（架構層）：
{
  "decision_id": "string (UUID)",
  "candidates": ["candidate_id[]"],
  "selected": "candidate_id",
  "reasoning": "string",
  "critic_scores": {"candidate_id": "score"},
  "confidence": "number (0-1)",
  "evidence_ptr": "string"
}


完整Schema Route-Out: ICD [SCHEMA-ARBITER-DECISION]
PoT執行器架構位置：
* Program-of-Thought（PoT）執行器作為Judge的推理輔助
* 位置：CA-DISTILL內部模組
* 職責：結構化推理鏈生成
約束：
* Fail-Closed：無有效候選→fallback手動審核
* 可追溯：每次仲裁決策留evidence_ptr
* 一致性：同樣輸入應產生相同仲裁結果（deterministic when seeded）
Route-Out：
* 規則詳細定義：ICD [SCHEMA-ARBITER-RULES]
* 驗收條件：SRS §3.17 [SRS-V700-FR-LLM-FACTORY]
________________


§4.18 ICT Technique Hot-Swap Architecture
[ANCHOR:ARCH-ICT-HOTSWAP] [NEW:PATCH-001] [RENUMBERED from §4.19 via PATCH-R3-SUB]
架構目標：支援REQ21-09「ICT技術模組熱插拔能力」，實現「一次定義、多次複用、可版本回退」。
Technique Registry架構定位：
屬性
	說明
	存放位置
	/spartoi_flow/technique_inventory/technique_inventory.jsonl
	管理職責
	CA-METHOD負責Registry維護，CA-GOVERN負責熱插拔控制
	索引機制
	雙鍵綁定（slot_key + methodcard_key）
	雙鍵綁定定義（架構層）：
* slot_key：ICT模組槽位標識（#1-#107），對應原始技術編號
* methodcard_key：方法卡唯一標識（methodcard_id + version），指向實際實現
* 綁定關係：slot_key ↔ methodcard_key 為1:N映射（同slot可綁定多版本methodcard）
* 當前激活：每slot只有1個active methodcard（由status=ACTIVE標識）
最小欄位（架構層）：
{
  "technique_id": "string (ICT #1-#107)",
  "slot_key": "string (slot identifier)",
  "methodcard_key": "string (methodcard_id:version)",
  "status": "enum (ACTIVE|DISABLED|REPLACED|DEPRECATED)",
  "evidence_ptr": "string (source evidence reference)",
  "activated_at": "timestamp",
  "deactivated_at": "timestamp|null"
}


完整Schema Route-Out: ICD [SCHEMA-ICT-TECHNIQUE-REGISTRY]
四路徑切換機制（架構級）：
路徑
	觸發條件
	行為
	Fail-Closed
	DISABLED
	人工停用
	slot保留但不執行
	訊號產生時skip
	REPLACED
	新版上線
	新版覆蓋舊版，舊版降為DEPRECATED
	新版驗證失敗→回滾
	ROLLBACK
	回滾請求
	恢復至指定歷史版本
	目標版本不存在→FAIL
	A-B TEST
	對照驗證
	雙版本並行，主版本執行、影子版本記錄
	不影響交易執行
	Fail-Closed策略：
異常條件
	事件
	行為
	methodcard_key為null
	BINDING_MISSING
	禁止用legacy_ref代打，直接FAIL
	同slot多卡ACTIVE
	MULTI_ACTIVE_CONFLICT
	自動選取最新版，發WARNING
	slot不存在
	SLOT_NOT_FOUND
	拒絕操作，發ERROR
	Route-Out：
* ICD [SCHEMA-ICT-TECHNIQUE-REGISTRY]：完整Schema定義
* ICD [SCHEMA-ICT-HOTSWAP-LOG]：切換歷史紀錄Schema
* SRS §3.20 [SRS-V700-FR-ICT]：驗收條件
* Runbook [RUNBOOK-ICT-HOTSWAP]：切換操作步驟
§4.18.6 ICT Localization Architecture
[ANCHOR:ARCH-ICT-LOCALIZATION] [NEW:PATCH-R3-012]
架構定位：ICT模組MUST支援台股在地化；台股特定常數MUST NOT硬編碼於DSL原語。
在地化參數注入機制：
參數類型
	來源
	注入點
	時間窗
	MarketProfile
	ICT Technique載入時
	價格限制
	MarketProfile
	ICT Technique載入時
	交易規則
	SessionPolicy
	ICT Technique執行時
	架構流程：
[ICT Technique載入]
    ↓
[讀取MarketProfile] → [注入market參數]
    ↓
[讀取SessionPolicy] → [注入session參數]
    ↓
[Technique實例化] → [含台股在地化參數]


約束：
* Technique內部禁止硬編碼任何市場常數（由Lint規則強制）
* 所有市場參數MUST透過MarketProfile注入
* 跨市場Technique切換透過MarketProfile版本切換實現
Route-Out：在地化規格見ICD [SCHEMA-ICT-LOCALIZATION]
________________


§4.19 WebTools-NA協作架構
[ANCHOR:ARCH-WTNA] [NEW:PATCH-R5-003]
架構定位：WebTools-NA（No-API）為人工複製貼上協作模式的獨立架構，與Browser Automation（RPA自動化）分離。
SRS對齊：SRS §3.19 [SRS-V700-FR-WTNA] 定義WebTools-NA獨立需求。
關鍵區分：
特性
	WebTools-NA
	Browser Automation
	定位
	人工複製貼上協作
	RPA自動化
	操作主體
	人工
	Playwright腳本
	架構章節
	§4.19 (本節)
	§3.4
	SRS對應
	SRS §3.19
	SRS §3.18 (部分)
	使用場景
	LLM交互、手動驗證
	自動化操作、螢幕錄製
	§4.19.1 WebTools-NA定義與範圍
[ANCHOR:ARCH-WTNA-SCOPE]
定義：
* WebTools-NA = Web Tools with No-API（無API的Web工具協作）
* 使用Web AI工具（Claude/ChatGPT等）進行人工複製貼上協作
* 不依賴付費API，維持No-Required-Cloud-LLM-API原則
範圍邊界：
在範圍內
	不在範圍內
	人工複製提示詞至LLM Web介面
	LLM API呼叫
	人工複製LLM回應至系統
	自動化LLM交互
	語意驗證與格式檢查
	GUI自動化操作
	會話記錄與可重演性
	直接交易下單
	提示詞模板管理
	非白名單網路存取
	適用SF節點：
SF範圍
	WT-NA適用性
	說明
	SF-01~03
	備用路徑
	本地處理為主，必要時降級
	SF-04~05
	備用路徑
	同上
	SF-06~08
	不適用
	必須本地執行
	SF-09~10
	備用路徑
	XQ失敗時降級
	SF-11~17
	不適用
	交易風險，必須本地執行
	§4.19.2 人工複製貼上工作流
[ANCHOR:ARCH-WTNA-WORKFLOW]
標準工作流架構：
┌─────────────────────────────────────────────────────────────────┐
│                WebTools-NA 工作流架構                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. 準備階段                                                     │
│  ┌─────────────────┐                                            │
│  │ CA-COLLAB       │                                            │
│  │ Prompt Assembler│────→ prompt_manifest.json                  │
│  └─────────────────┘                                            │
│           │                                                     │
│           │ 組裝提示詞                                           │
│           ↓                                                     │
│  2. 人工操作階段                                                  │
│  ┌─────────────────┐      ┌─────────────────┐                   │
│  │ 操作者複製      │      │ Web AI介面      │                   │
│  │ 提示詞至剪貼簿  │─────→│ (Claude/GPT等)  │                   │
│  └─────────────────┘      └─────────────────┘                   │
│                                  │                              │
│                                  │ LLM處理                       │
│                                  ↓                              │
│  ┌─────────────────┐      ┌─────────────────┐                   │
│  │ 操作者複製      │      │ LLM回應         │                   │
│  │ 回應至系統      │←─────│                 │                   │
│  └─────────────────┘      └─────────────────┘                   │
│           │                                                     │
│           │ 貼上回應                                             │
│           ↓                                                     │
│  3. 驗證階段                                                     │
│  ┌─────────────────┐                                            │
│  │ Format Validator│                                            │
│  │ (CA-COLLAB)     │────→ 格式驗證                               │
│  └─────────────────┘                                            │
│           │                                                     │
│           ↓                                                     │
│  ┌─────────────────┐                                            │
│  │ Semantic Checker│                                            │
│  │ (CA-DISTILL/    │────→ 語意驗證                               │
│  │  CA-METHOD)     │                                            │
│  └─────────────────┘                                            │
│           │                                                     │
│           │ 驗證通過                                             │
│           ↓                                                     │
│  4. 記錄階段                                                     │
│  ┌─────────────────┐                                            │
│  │ Session Logger  │────→ wtna_action_log.jsonl                 │
│  │ (CA-COLLAB)     │────→ response_trace.jsonl                  │
│  └─────────────────┘                                            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘


工作流步驟詳述：
步驟
	執行者
	輸入
	輸出
	失敗處理
	1. 組裝提示詞
	CA-COLLAB
	上下文資料
	prompt_manifest.json
	Fail-Closed
	2. 複製提示詞
	人工
	prompt_manifest
	剪貼簿
	人工重試
	3. 貼至LLM
	人工
	剪貼簿
	LLM輸入
	人工重試
	4. 取得回應
	人工
	LLM輸出
	剪貼簿
	人工重試
	5. 貼回系統
	人工
	剪貼簿
	系統接收
	人工重試
	6. 格式驗證
	CA-COLLAB
	回應文字
	validation_result
	顯示錯誤+重試
	7. 語意驗證
	CA-DISTILL
	回應+提示詞
	semantic_result
	拒絕採納
	8. 會話記錄
	CA-COLLAB
	全流程
	logs
	警告但不阻斷
	§4.19.3 必備工件
[ANCHOR:ARCH-WTNA-ARTIFACTS]
工件清單：
工件
	產生者
	用途
	Schema參照
	wtna_action_log.jsonl
	CA-COLLAB
	記錄每次WT-NA操作
	ICD [SCHEMA-WTNA-LOG]
	prompt_manifest.json
	CA-COLLAB
	提示詞清單與hash
	ICD [SCHEMA-PROMPT-MANIFEST]
	response_trace.jsonl
	CA-COLLAB
	回應追溯記錄
	ICD [SCHEMA-RESPONSE-TRACE]
	wtna_session.json
	CA-COLLAB
	會話完整記錄
	ICD [SCHEMA-WTNA-SESSION]
	wtna_action_log.jsonl Schema（架構層）：
{
  "log_id": "string (UUID)",
  "session_id": "string (UUID)",
  "timestamp": "ISO8601",
  "action_type": "PROMPT_COPY|RESPONSE_PASTE|VALIDATION",
  "prompt_hash": "string (SHA256)",
  "response_hash": "string (SHA256)",
  "operator_id": "string",
  "llm_provider": "CLAUDE|GPT|GEMINI|OTHER",
  "validation_result": {
    "format_ok": true,
    "semantic_ok": true,
    "errors": []
  },
  "duration_seconds": "number"
}


可重演性保證架構：
記錄項目
	目的
	儲存位置
	prompt_hash
	確保提示詞一致性
	wtna_action_log
	response_hash
	確保回應可追溯
	wtna_action_log
	timestamp
	時間序列重建
	wtna_action_log
	operator_id
	操作者識別
	wtna_action_log
	llm_provider
	LLM來源記錄
	wtna_action_log
	Fail-Closed行為：
* 格式驗證失敗 → 顯示錯誤訊息 + 提供格式範例 + 允許重試
* 語意驗證失敗 → 拒絕採納該回應 + 記錄失敗原因
* 記錄失敗 → 警告 + 繼續（降級運行）
§4.19.4 與Browser Automation的關係
[ANCHOR:ARCH-WTNA-VS-BA]
架構關係圖：
┌─────────────────────────────────────────────────────────────────┐
│              WebTools-NA vs Browser Automation                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    外部交互層                            │   │
│  ├─────────────────────────────────────────────────────────┤   │
│  │                                                         │   │
│  │  ┌─────────────────┐        ┌─────────────────┐        │   │
│  │  │ WebTools-NA     │        │ Browser         │        │   │
│  │  │ (人工複製貼上)   │        │ Automation      │        │   │
│  │  │ §4.19           │        │ (Playwright)    │        │   │
│  │  │                 │        │ §3.4            │        │   │
│  │  └────────┬────────┘        └────────┬────────┘        │   │
│  │           │                          │                  │   │
│  │           │  ┌─────────────────────┐ │                  │   │
│  │           │  │ 共用介面            │ │                  │   │
│  │           └──│ - Session Logger    │─┘                  │   │
│  │              │ - Evidence Archive  │                    │   │
│  │              │ - Replay Mechanism  │                    │   │
│  │              └─────────────────────┘                    │   │
│  │                                                         │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              │                                  │
│                              ↓                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                     CA-COLLAB                            │   │
│  │             (統一管理外部交互)                            │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘


功能對照：
功能
	WebTools-NA
	Browser Automation
	執行方式
	人工
	自動化腳本
	主要用途
	LLM交互
	螢幕操作/錄製
	證據形式
	prompt/response hash
	螢幕錄影/trace.zip
	延遲敏感度
	低（人工節奏）
	高（自動化效率）
	失敗處理
	人工重試
	腳本重試/降級
	共享基礎設施：
元件
	用途
	位置
	Session Logger
	會話記錄
	CA-COLLAB
	Evidence Archive
	證據歸檔
	Artifact Store
	Replay Mechanism
	回放能力
	CA-UI
	降級路徑：
* Browser Automation失敗 → 可降級至WebTools-NA（人工接管）
* WebTools-NA不可用 → 無自動降級（需人工判斷）
§4.19.5 三路徑路由架構
[ANCHOR:ARCH-THREE-PATH-ROUTING]
三路徑定義：
路徑
	代碼
	說明
	適用場景
	LOCAL
	LOCAL
	本地處理
	預設路徑，無外部依賴
	WT-NA
	WTNA
	WebTools-NA協作
	需LLM能力但無API
	XQ-API
	XQAPI
	XQ/XS平台API
	執行/轉譯相關
	路由決策架構：
┌─────────────────────────────────────────────────────────────────┐
│                     三路徑路由決策架構                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  [任務請求]                                                      │
│       │                                                         │
│       ↓                                                         │
│  ┌──────────────────┐                                           │
│  │ Route Decider    │                                           │
│  │ (CA-GOVERN)      │                                           │
│  └──────────────────┘                                           │
│       │                                                         │
│       │ 依據：SF節點 + 任務類型 + 系統狀態                        │
│       │                                                         │
│       ├─────────────────────────────────────┐                   │
│       │                    │                │                   │
│       ↓                    ↓                ↓                   │
│  ┌─────────┐        ┌─────────┐      ┌─────────┐               │
│  │ LOCAL   │        │ WT-NA   │      │ XQ-API  │               │
│  │ (預設)  │        │ (備用)  │      │ (執行)  │               │
│  └─────────┘        └─────────┘      └─────────┘               │
│       │                    │                │                   │
│       │                    │                │                   │
│       └────────────────────┼────────────────┘                   │
│                            │                                    │
│                            ↓                                    │
│                    ┌───────────────┐                            │
│                    │ 結果彙整      │                            │
│                    │ + 證據記錄    │                            │
│                    └───────────────┘                            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘


SF節點路由配置表：
SF範圍
	主路徑
	備用路徑
	Fail-Closed行為
	SF-00
	LOCAL
	-
	必須本地（Preflight）
	SF-01~03
	LOCAL
	WT-NA
	無法本地→降級至WT-NA
	SF-04~05
	LOCAL
	WT-NA
	同上
	SF-06~08
	LOCAL
	-
	必須本地執行（回測/TA）
	SF-09
	LOCAL + XQ-API
	WT-NA
	XQ失敗→降級至WT-NA
	SF-10
	LOCAL + XQ-API
	WT-NA
	同上
	SF-11
	LOCAL
	-
	必須本地（HITL Gate）
	SF-12~17
	LOCAL + XQ-API
	-
	必須本地+XQ（交易風險）
	SF-31
	LOCAL
	-
	必須本地（績效）
	路由降級規則：
觸發條件
	降級動作
	記錄事件
	LOCAL處理失敗
	嘗試WT-NA（若允許）
	route_fallback_wtna
	XQ-API不可用
	嘗試WT-NA（若允許）
	route_fallback_wtna
	WT-NA驗證失敗
	人工介入
	wtna_validation_failed
	所有路徑失敗
	Fail-Closed
	route_all_failed
	Route-Out：
* WT-NA詳細流程：執行手冊v2.1.0 APPX-B
* ICD契約：[CONTRACT-WTNA-001], [CONTRACT-WTNA-002]
* 驗收條件：SRS §3.19 [SRS-V700-FR-WTNA]
________________


§5 Spartoi Flow（SF主鍵）
§5.1 SF Primary Key Policy
[ANCHOR:ARCH-SF-PRIMARY-KEY]
SF主鍵體系是Spartoi流程的唯一索引機制。
原則：
* 每個SF節點有唯一主鍵（SF-xx）
* 主鍵不可重複使用
* 主鍵與子系統職責綁定
§5.1.2 WT-NA協作模式（WebTools No-API）
[ANCHOR:ARCH-WT-NA-MODE]
WT-NA定義：
* 使用Web AI工具（如Claude/ChatGPT等）進行人工複製貼上協作
* 不依賴付費API，維持No-Required-Cloud-LLM-API原則
架構流程：
1. 準備輸入（由CA-COLLAB組裝提示詞）
2. 人工複製至Web AI介面
3. 取得回應並複製回系統
4. 語意驗證（由CA-DISTILL/CA-METHOD執行）
5. 可重演性保證（記錄prompt_hash + response_hash）
必備工件：
工件
	產生者
	用途
	Schema參照
	wtna_action_log.jsonl
	CA-COLLAB
	記錄每次WT-NA操作
	ICD [SCHEMA-WTNA-LOG]
	prompt_manifest.json
	CA-COLLAB
	提示詞清單與hash
	ICD [SCHEMA-PROMPT-MANIFEST]
	response_trace.jsonl
	CA-COLLAB
	回應追溯記錄
	ICD [SCHEMA-RESPONSE-TRACE]
	可重演性保證：
* 每次WT-NA操作必須記錄：prompt_hash, response_hash, timestamp, operator_id
* 語意驗證Gate：response與prompt的語意一致性驗證
* Fail-Closed：驗證失敗→拒絕採納該回應
三路徑路由表（架構層）：
SF範圍
	主路徑
	備用路徑
	Fail-Closed行為
	SF-01~03
	LOCAL
	WT-NA
	無法本地處理時降級至WT-NA
	SF-04~05
	LOCAL
	WT-NA
	同上
	SF-06~08
	LOCAL
	-
	必須本地執行
	SF-09~10
	LOCAL + XQ-API
	WT-NA
	XQ失敗時降級至WT-NA
	SF-11~17
	LOCAL
	-
	必須本地執行（交易風險）
	Route-Out：WT-NA詳細流程見執行手冊v2.1.0 APPX-B
§5.2 SF Node Index
[ANCHOR:ARCH-SF-INDEX]
SF節點
	名稱
	子系統
	職責
	SF-00
	Preflight
	CA-GOVERN
	流程前置檢查
	SF-01
	WRC入庫
	CA-WRC
	教材入庫
	SF-02
	語料處理
	CA-CORPUS
	分塊/索引
	SF-03
	蒸餾
	CA-DISTILL
	LLM蒸餾
	SF-04
	IR生成
	CA-DSL
	中間表示
	SF-05
	方法卡
	CA-METHOD
	MethodCard生成
	SF-06
	版本確認
	CA-METHOD
	版本鎖定
	SF-07
	回測
	CA-BACKTEST
	Walk-Forward
	SF-08
	TA/選股
	CA-TA/CA-SELECT
	技術分析/選股
	SF-09
	轉譯
	CA-TRANSLATE
	XS/XQ轉譯
	SF-10
	盯盤
	CA-WATCH
	信號監控
	SF-11
	HITL決策
	(Gate)
	人工決策門
	SF-12~17
	執行
	CA-EXECUTE
	下單/監控
	SF-31
	績效
	CA-PERFORM
	績效分析
	§5.2.1 SF節點前後條件（Preconditions/Postconditions）
[ANCHOR:ARCH-SF-PRECOND-POSTCOND]
SF
	Preconditions
	Postconditions
	Fail-Closed行為
	SF-00
	system_config存在且驗證通過
	preflight_report.status=PASS
	禁止進入SF-01
	SF-01
	preflight_report.status=PASS
	wrc_manifest存在
	阻斷知識管線
	SF-02
	wrc_manifest存在
	corpus_manifest存在
	阻斷蒸餾
	SF-03
	corpus_manifest存在
	distill_units產出
	阻斷方法卡
	SF-04
	distill_units存在
	dsl_primitives定義
	阻斷方法卡
	SF-05
	dsl_primitives存在
	methodcard產出
	阻斷回測
	SF-06
	methodcard存在
	backtest_result產出
	阻斷分析
	SF-07
	backtest_result存在
	ta_package產出
	阻斷選股
	SF-08
	ta_package存在
	topk_candidates產出
	阻斷翻譯
	SF-09
	topk_candidates存在
	xs_script產出
	阻斷執行
	SF-10
	xs_script存在
	translated_output驗證通過
	阻斷盯盤
	SF-11
	候選訊號存在
	HITL決策完成
	阻斷執行（必須人工確認）
	SF-12
	HITL確認通過
	watch_signal產出
	阻斷執行
	SF-13~SF-17
	watch_signal存在
	execute_record產出
	阻斷績效
	SF-18~SF-30
	Reserved
	Reserved
	Reserved
	SF-31
	execute_record存在
	perform_report產出
	記錄但不阻斷
	架構約束：
* 每個SF節點的Postcondition是下一節點的Precondition
* 任一Precondition不滿足 → Fail-Closed，禁止進入該節點
* SF-11(HITL)為強制人工確認點，無法自動跳過
Route-Out：SF詳細規格見執行手冊v2.1.0 §7
§5.3 SF Data Flow
[ANCHOR:ARCH-SF-DATAFLOW]
[SF-01 WRC] → [SF-02 CORPUS] → [SF-03 DISTILL] → [SF-04 DSL]
                                     ↓
                                 [SEG Gate]
                                     ↓
[SF-05 METHOD] → [SF-06 VER] → [SF-07 BACKTEST] → [SF-08 TA/SELECT]
       ↓
   [MSG Gate]
       ↓
[SF-09 TRANSLATE] → [TVG Gate] → [SF-10 WATCH] → [SF-11 HITL] → [SF-12~17 EXECUTE]
                                                                       ↓
                                                               [SF-31 PERFORM]


§5.3.2 Evidence Chain Table（ICRU能力鏈）
[ANCHOR:ARCH-EVIDENCE-CHAIN] [NEW:PATCH-003]
每段SF流程的I/O與evidence_ptr綁定：
SF段落
	input_artifacts
	output_artifacts
	evidence_ptr_binding
	Fail-Closed
	SF-01→SF-03 (蒸餾)
	corpus_index, chunks
	evidence_card, technique_spec
	chunk_id + offset
	無binding→拒收output
	SF-03→SF-05 (IR/Primitive)
	technique_spec
	primitive_spec, ir_bundle
	technique_id
	spec缺失→FAIL
	SF-05→SF-06 (MethodCard)
	primitive_spec
	methodcard.json
	primitive_ref
	ref缺失→FAIL
	SF-06→SF-07 (Backtest)
	methodcard.json
	backtest_report
	methodcard_id
	id缺失→FAIL
	SF-07→SF-08 (TA Package)
	backtest_report
	ta_package.json
	backtest_run_id
	run_id缺失→FAIL
	SF-08→SF-09 (TopK)
	ta_package.json
	topk_candidates
	ta_ref
	ref缺失→FAIL
	SF-09→SF-10 (XS Script)
	topk_candidates
	xs_script.xs
	candidate_ids
	ids缺失→FAIL
	SF-10→SF-11 (Watch/HITL)
	xs_script.xs
	hitl_decision
	signal_ref
	ref缺失→FAIL
	SF-11→SF-12 (Execute)
	hitl_decision
	execution_log
	decision_id
	id缺失→FAIL
	架構約束：
* 強制性：每段output MUST可回指input的evidence_ptr
* 驗證點：每個SF節點的JobCard必含evidence_ptr欄位
* 缺失處理：evidence_ptr缺失→該工件視為無效→Fail-Closed
Route-Out：Schema細節見ICD [CONTRACT-SF-*]
________________


§5.3.2 ICRU能力鏈（Evidence Chain Table）
[ANCHOR:ARCH-ICRU-EVIDENCE-CHAIN]
能力鏈流程： 蒸餾→IR/Primitive→MethodCard→Backtest→TA Package→TopK→XS Script→Watch/HITL→Execute→Perform
每段I/O與evidence_ptr綁定：
能力段
	SF範圍
	input_artifacts
	output_artifacts
	evidence_ptr
	缺失處理
	蒐集
	SF-01
	-
	wrc_manifest.json
	→ source_id
	Fail-Closed
	語料
	SF-02
	wrc_manifest
	corpus_manifest.json
	→ wrc entry
	Fail-Closed
	蒸餾
	SF-03
	corpus_manifest
	distill_units.jsonl
	→ corpus段落
	Fail-Closed
	原語
	SF-04
	distill_units
	dsl_primitives
	→ distill_id
	Fail-Closed
	方法
	SF-05
	dsl_primitives
	methodcard.json
	→ primitive_id
	Fail-Closed
	回測
	SF-06
	methodcard
	backtest_result.json
	→ methodcard_id
	Fail-Closed
	分析
	SF-07
	backtest_result
	ta_package.json
	→ backtest_id
	Fail-Closed
	選股
	SF-08
	ta_package
	topk_candidates.json
	→ ta_id
	Fail-Closed
	執行
	SF-12~17
	topk_candidates
	execute_record.json
	→ candidate_id
	Fail-Closed
	績效
	SF-31
	execute_record
	perform_report.json
	→ execute_id
	記錄但不阻斷
	架構約束：
* 強制性：每段output MUST可回指input的evidence_ptr
* 驗證點：每個SF節點的JobCard必含evidence_ptr欄位
* 缺失處理：evidence_ptr缺失→該工件視為無效→Fail-Closed
* Reconcile規則：Execute→Perform段的evidence_ptr必須綁定execute_record.execute_id
Route-Out：能力鏈詳細定義見P1-ICRU v1.0.0
§5.4 SF-11 HITL Decision Gate
[ANCHOR:ARCH-HITL-GATE]
定位：SF-11是HITL決策門（Gate），不是獨立子系統。
執行手冊對齊驗證（對齊執行手冊v2.1.0 §6.1）：
* 執行手冊定義：「SF-11 HITL決策門是Candidate→Signal的強制關卡」
* 執行手冊錨點：[SFHB-V2-07-SF11]
* 對齊結果：✅ 確認一致（定義一致）
架構約束：
* SF-11 MUST 由CA-WATCH觸發
* SF-11 MUST 需人工確認後才能進入CA-EXECUTE
* SF-11 不可被bypass（除系統強制降級）
§5.4.2 Decision Package Architecture
[ANCHOR:ARCH-DECISION-PACKAGE] [NEW:PATCH-R3-007]
架構定位：每個HITL決策點生成Decision Package工件。
產生位置：CA-WATCH（信號產生時）+ CA-UI（人工確認時）
存放位置：Artifact Store /artifacts/decisions/
最小欄位（架構層 - 13欄位）：
{
  "decision_id": "string (UUID)",
  "signal_id": "string",
  "decision_point": "string",
  "decision": "APPROVE|REJECT|MODIFY|DEFER",
  "recommended_default": "string",
  "override_reason": "string (required if decision≠recommended_default)",
  "confidence_score": "number (0-1)",
  "evidence_refs": ["evidence_ptr[]"],
  "human_operator_id": "string",
  "decision_timestamp": "ISO8601",
  "context_snapshot": "object",
  "risk_assessment": "object",
  "subsequent_action": "string"
}


Route-Out：完整Schema見ICD [SCHEMA-DECISION-PACKAGE]
§5.4.3 Dual-Write Mechanism
[ANCHOR:ARCH-DECISION-DUALWRITE] [NEW:PATCH-R3-007]
架構目的：確保決策可追溯性。
Dual-Write目標：
1. decision_points.log（決策專用日誌）
2. event_log.jsonl（通用事件日誌）
寫入順序：
1. 先寫decision_points.log（主記錄）
2. 後寫event_log.jsonl（事件記錄）
3. 兩者均成功才確認Decision Package落盤
失敗處理：
* 任一寫入失敗→重試3次
* 重試失敗→阻斷後續流程 + 產生DECISION_WRITE_FAILED事件
一致性保證：transaction_id關聯兩份記錄
§5.4.4 Decision Validation Architecture
[ANCHOR:ARCH-DECISION-VALIDATION] [NEW:PATCH-R3-007]
驗證器位置：CA-GOVERN Validators
Fail-Closed規則：
條件
	事件
	行為
	decision欄位為空
	DECISION_MISSING
	阻斷後續流程
	decision≠recommended_default且override_reason為空
	OVERRIDE_REASON_MISSING
	BLOCK_RELEASE
	evidence_refs為空
	EVIDENCE_MISSING
	警告 + 標記PROVISIONAL
	Route-Out：Gate定義見SRS §0.4 [SRS-V700-GATE-HITL]
________________


§5.5 T0/T1 Dual Mode
[ANCHOR:ARCH-T0-T1-MODE]
T0_DAYTRADE（當沖主線）：
* 當日內完成進出場
* 遵循時間窗約束（見§8.4）
T1_SWING（隔日沖副線）：
* 允許隔夜持倉
* 四項T1專屬工件：
   1. MethodCard_T1
   2. RiskCard_T1
   3. OvernightPositionLedger
   4. NextDayExitPlan
Route-Out：T1工件Schema見ICD [SCHEMA-T1-*]（CR_OPEN）
________________


§5.6 JobCard Architecture
[ANCHOR:ARCH-JOBCARD] [NEW:PATCH-R5-002]
架構定位：JobCard為Spartoi Flow的任務執行契約，每個SF節點執行時MUST產生對應JobCard。
SRS對齊：SRS §3.3 [SRS-V700-FR-JOBCARD] 定義JobCard需求。
§5.6.1 JobCard結構定義
[ANCHOR:ARCH-JOBCARD-STRUCT]
最小必備欄位（9欄位，對齊SRS §3.3 SRS-FR-JOBCARD-001）：
欄位
	型態
	必備
	說明
	job_id
	string (UUID)
	✅
	唯一識別碼
	sf_ref
	string
	✅
	對應SF節點（SF-00~SF-31）
	inputs
	object[]
	✅
	輸入檔案/格式/schema
	preconditions
	object[]
	✅
	環境/資料庫狀態/模式前置條件
	commands
	string[]
	✅
	最小CLI/腳本指令
	acceptance
	object
	✅
	產物檢核規則（通過條件）
	logs
	object
	✅
	必要日誌欄位定義
	rollback
	object
	✅
	回滾策略與步驟
	kill_switch
	object
	✅
	緊急停止條件與處理
	架構層Schema（概念）：
{
  "job_id": "string (UUID)",
  "sf_ref": "SF-xx",
  "inputs": [
    {
      "artifact_path": "string",
      "schema_ref": "string (ICD anchor)",
      "required": true,
      "validation_rule": "string"
    }
  ],
  "preconditions": [
    {
      "condition_id": "string",
      "condition_type": "ENV|STATE|MODE|GATE",
      "expected_value": "any",
      "fail_action": "BLOCK|WARN|SKIP"
    }
  ],
  "commands": ["string (CLI/script)"],
  "acceptance": {
    "criteria": [{"rule": "string", "threshold": "any"}],
    "verification_method": "AUTO|MANUAL|HYBRID"
  },
  "logs": {
    "event_type": "string",
    "required_fields": ["string[]"],
    "retention_days": "integer"
  },
  "rollback": {
    "strategy": "REVERT|COMPENSATE|MANUAL",
    "steps": ["string[]"],
    "timeout_seconds": "integer"
  },
  "kill_switch": {
    "trigger_conditions": ["string[]"],
    "actions": ["string[]"],
    "escalation_path": "string"
  }
}


Route-Out：完整Schema見ICD [SCHEMA-JOBCARD]
§5.6.2 JobCard生命週期
[ANCHOR:ARCH-JOBCARD-LIFECYCLE]
狀態機定義：
┌─────────────────────────────────────────────────────────────────┐
│                    JobCard 生命週期狀態機                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌──────────┐     ┌──────────┐     ┌──────────┐               │
│   │ CREATED  │────→│ VALIDATED│────→│ RUNNING  │               │
│   └──────────┘     └──────────┘     └──────────┘               │
│        │                │                │                      │
│        │ validation_    │ precond_       │                      │
│        │ failed         │ failed         │                      │
│        ↓                ↓                ↓                      │
│   ┌──────────┐     ┌──────────┐    ┌──────────┐  ┌──────────┐ │
│   │ INVALID  │     │ BLOCKED  │    │ COMPLETED│  │ FAILED   │ │
│   └──────────┘     └──────────┘    └──────────┘  └──────────┘ │
│                                          │             │        │
│                                          │   rollback  │        │
│                                          ↓      ↓      ↓        │
│                                    ┌──────────────────┐        │
│                                    │    ROLLED_BACK   │        │
│                                    └──────────────────┘        │
└─────────────────────────────────────────────────────────────────┘


狀態轉換矩陣：
起始狀態
	觸發事件
	目標狀態
	產生工件
	CREATED
	schema驗證通過
	VALIDATED
	jobcard_validated.event
	CREATED
	schema驗證失敗
	INVALID
	validation_error.log
	VALIDATED
	前置條件通過
	RUNNING
	jobcard_started.event
	VALIDATED
	前置條件失敗
	BLOCKED
	precond_failed.log
	RUNNING
	執行成功
	COMPLETED
	jobcard_completed.event
	RUNNING
	執行失敗
	FAILED
	execution_error.log
	FAILED
	rollback執行
	ROLLED_BACK
	rollback_completed.event
	COMPLETED
	需要回滾
	ROLLED_BACK
	rollback_completed.event
	生命週期架構流程：
[CA-UI上傳/SF觸發]
        ↓
[JobCard Parser] → 解析job_card.json
        ↓
[JobCard Validator] → Schema驗證 (CA-GOVERN)
        ↓ VALIDATED
[Precondition Checker] → 前置條件檢查
        ↓ RUNNING
[Orchestrator] → Pipeline調度執行
        ↓
[Acceptance Checker] → 產物檢核
        ↓ COMPLETED / FAILED
[Rollback Handler] → 失敗時觸發回滾
        ↓
[Event Logger] → 記錄最終狀態


架構約束：
* 每個JobCard狀態轉換MUST產生對應事件
* INVALID/BLOCKED狀態的JobCard不得進入執行
* FAILED狀態觸發自動rollback（若rollback.strategy≠MANUAL）
§5.6.3 JobCard與SF節點綁定
[ANCHOR:ARCH-JOBCARD-SF-BINDING]
綁定架構：每個SF節點有唯一JobCard模板，運行時實例化。
JobCard ↔ SF節點對照表：
SF節點
	JobCard Template ID
	主要職責
	子系統
	SF-00
	JC-PREFLIGHT
	流程前置檢查
	CA-GOVERN
	SF-01
	JC-WRC
	教材入庫
	CA-WRC
	SF-02
	JC-CORPUS
	語料處理
	CA-CORPUS
	SF-03
	JC-DISTILL
	蒸餾
	CA-DISTILL
	SF-04
	JC-DSL
	IR生成
	CA-DSL
	SF-05
	JC-METHOD
	方法卡生成
	CA-METHOD
	SF-06
	JC-VERSION
	版本確認
	CA-METHOD
	SF-07
	JC-BACKTEST
	回測
	CA-BACKTEST
	SF-08
	JC-SELECT
	選股
	CA-TA/CA-SELECT
	SF-09
	JC-TRANSLATE
	XS轉譯
	CA-TRANSLATE
	SF-10
	JC-WATCH
	盯盤
	CA-WATCH
	SF-11
	JC-HITL
	HITL決策門
	(Gate)
	SF-12~17
	JC-EXECUTE
	執行
	CA-EXECUTE
	SF-31
	JC-PERFORM
	績效分析
	CA-PERFORM
	綁定架構圖：
┌─────────────────────────────────────────────────────────────┐
│                  JobCard ↔ SF 綁定架構                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌────────────────┐        ┌────────────────┐              │
│  │ JobCard        │        │ SF Node        │              │
│  │ Template       │◆───────│ Definition     │              │
│  │ Registry       │  1:1   │ (§5.2)         │              │
│  └────────────────┘        └────────────────┘              │
│          │                        │                         │
│          │ instantiate            │ trigger                 │
│          ↓                        ↓                         │
│  ┌────────────────┐        ┌────────────────┐              │
│  │ JobCard        │        │ SF Node        │              │
│  │ Instance       │◆───────│ Execution      │              │
│  │ (runtime)      │  1:1   │ (runtime)      │              │
│  └────────────────┘        └────────────────┘              │
│          │                        │                         │
│          │                        │                         │
│          └────────────┬───────────┘                         │
│                       ↓                                     │
│              ┌────────────────┐                             │
│              │ Artifact Store │                             │
│              │ (evidence)     │                             │
│              └────────────────┘                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘


Composite Key設計：
* 格式：{sf_ref}@{job_id}
* 範例：SF-12@550e8400-e29b-41d4-a716-446655440000
* 用途：防止Stage ID漂移，確保JobCard與SF節點唯一對應
Route-Out：JobCard Template定義見ICD [SCHEMA-JOBCARD-TEMPLATE]
§5.6.4 JobCard失敗處理與Rollback
[ANCHOR:ARCH-JOBCARD-ROLLBACK]
失敗處理架構：
失敗類型
	觸發條件
	處理策略
	Fail-Closed行為
	VALIDATION_FAILED
	Schema驗證失敗
	拒絕執行
	阻斷流程
	PRECOND_FAILED
	前置條件不滿足
	等待/跳過/手動
	依配置決定
	EXECUTION_FAILED
	執行過程異常
	自動rollback
	觸發KILL-1
	ACCEPTANCE_FAILED
	產物檢核失敗
	重試/rollback
	依配置決定
	TIMEOUT
	超時未完成
	強制終止+rollback
	觸發KILL-2
	Rollback機制架構：
Rollback策略類型：
策略
	說明
	適用場景
	REVERT
	還原至執行前狀態
	資料變更可逆
	COMPENSATE
	執行補償動作
	資料變更不可逆但可補償
	MANUAL
	需人工介入
	複雜情境/高風險操作
	Rollback執行流程：
[FAILED狀態]
      ↓
[Rollback Handler啟動]
      ↓
[檢查rollback.strategy]
      │
      ├─ REVERT ──────→ [執行還原步驟] → [驗證還原結果]
      │
      ├─ COMPENSATE ──→ [執行補償動作] → [記錄補償結果]
      │
      └─ MANUAL ──────→ [產生人工介入請求] → [等待人工確認]
      │
      ↓
[更新狀態為ROLLED_BACK]
      ↓
[產生rollback_completed.event]


Kill-Switch整合：
Kill-Switch類型
	JobCard行為
	產生工件
	KILL-1
	立即終止當前JobCard + 禁止新JobCard
	kill_switch_log.jsonl
	KILL-2
	終止所有執行中JobCard + 系統降級
	emergency_stop.event
	KILL-3
	全系統凍結 + 等待人工介入
	freeze_system.event
	Rollback Timeout架構：
* 默認timeout：300秒（5分鐘）
* 可配置：每個JobCard可覆蓋默認值
* 超時處理：升級為KILL-2 + 產生ROLLBACK_TIMEOUT事件
Route-Out：
* Rollback Schema：ICD [SCHEMA-JOBCARD-ROLLBACK]
* Kill-Switch定義：§8.4.4 [ANCHOR:ARCH-KILL-SWITCH]
* 驗收條件：SRS §3.3 [SRS-V700-FR-JOBCARD]
________________


§6 Control Plane（控制面）
§6.0 Gate分層架構
[ANCHOR:ARCH-GATE-LAYER] [NEW:PATCH-R4-002]
Gate體系分成「裁決（Policy）」與「檢核（Check）」兩層，嚴禁混用。
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│ 1. 輸入工件      │────→│ 2. gate_id       │────→│ 3. gate_policy   │
│ (artifacts)      │     │ 檢核判定         │     │ 裁決輸出         │
└──────────────────┘     └──────────────────┘     └──────────────────┘
                                │
                                ↓
                        ┌──────────────────┐
                        │ 4. 寫入          │
                        │ gate_result.json │
                        └──────────────────┘


架構硬規則：
* 每個gate_id在Gate Dictionary必須映射到一個gate_policy（Outcome）
* 每條需求必填兩欄：gate_policy + gate_id
* validation_hook.json承載gate檢核結果
Route-Out：Gate Dictionary詳細定義見SRS §0.4.2 [SRS-V700-GATE-DICT]
________________


§6.0.1 Gate Policy（裁決層）
[ANCHOR:ARCH-GATE-POLICY]
gate_policy固定只允許三態（禁止擴充）：
gate_policy
	說明
	影響範圍
	使用場景
	BLOCK_RELEASE
	阻斷發布
	全系統禁止進入下一階段
	驗收失敗/安全違規
	RADAR_ONLY
	允許觀測
	禁止進EXECUTE，允許產工件
	品質未達標/實驗階段
	EXECUTE_DISABLED
	運行期禁用
	禁止高風險動作
	Kill Switch/HITL介入
	架構約束：
* BLOCK_RELEASE > RADAR_ONLY > EXECUTE_DISABLED（優先級）
* 多個gate_id結果衝突時，取優先級最高的gate_policy
* 任何gate_policy變更必須記錄到gate_result.json
________________


§6.0.2 Gate ID（檢核層）
[ANCHOR:ARCH-GATE-ID]
gate_id為檢核碼，由各子系統/流程定義，映射到gate_policy。
Gate ID命名規範：
GATE-{CATEGORY}-{SEQ}


Category分類：
Category
	說明
	範例
	RL
	Release Gate
	GATE-RL-001
	RC
	Release Candidate
	GATE-RC5
	GOV
	Governance Gate
	GATE-GOV-002
	SEM3
	SEM³ Gate
	GATE-SEM3-SGF
	HITL
	HITL Gate
	GATE-HITL
	TVE
	TVE Gate
	GATE-TVE
	Route-Out：完整Gate ID索引見SRS §0.4.2
________________


§6.1 Flag Registry
[ANCHOR:ARCH-FLAG-REGISTRY] [UPDATED:PATCH-R4-003]
ARCH旗標治理硬規則：
1. SRS擁有Tier-0授權級旗標唯一解釋權
2. ARCH MUST NOT自創同名異義旗標
3. ARCH只能Route-Out指向SRS §5.1.1 [SRS-V700-FLAG-TIERING]
旗標SSOT聲明：
* Flag Registry唯一來源（SSOT）：SRS §5.1.1
* ARCH本節為SRS旗標定義的架構層引用，非定義本體
* 任何旗標語義/默認值以SRS為準
Route-Out：旗標完整定義見SRS §5.1.1 [SRS-V700-FLAG-TIERING]
________________


§6.1.1 旗標分層架構（Flag Tiering）
[ANCHOR:ARCH-FLAG-TIERING] [NEW:PATCH-R4-003]
依據SRS v7.0.0-patch2旗標分層設計（對齊《全文件最終增補升級方案v2》）：
┌─────────────────────────────────────────────────────────────────┐
│  Tier-0（全系統一級旗標）                                         │
│  ═══════════════════════════════════════════════════════════════ │
│  數量硬限：≤3個                                                   │
│  職責：控制高風險治理裁決（不可逆事故防線）                          │
│  SSOT：SRS授權，ARCH只能Route-Out指向SRS                          │
├─────────────────────────────────────────────────────────────────┤
│  Tier-1（模式/能力旗標）                                          │
│  ═══════════════════════════════════════════════════════════════ │
│  狀態：全部CR_OPEN，P1不升格                                       │
│  職責：控制Agent模式、T1模式、ICT熱插拔等能力開關                   │
│  約束：不得影響Tier-0安全裁決                                      │
├─────────────────────────────────────────────────────────────────┤
│  Tier-2（交易域限制旗標）                                          │
│  ═══════════════════════════════════════════════════════════════ │
│  狀態：CR_OPEN或P2 Flag                                           │
│  職責：控制自動下單、融資融券等交易動作                             │
│  限制：不得與Tier-0同級，默認=false                                 │
└─────────────────────────────────────────────────────────────────┘


Tier-0 一級旗標（SRS授權，≤3個）：
flag_id
	名稱
	職責
	默認值
	safe_default理由
	allow_xsat
	XSAT自動化開關
	控制高風險輸出/自動化決策
	false
	禁止自動交易=最保守
	require_full_review
	完整審核要求
	不經完整審核不得放行
	true
	強制審核=最保守
	allow_bypass_contract
	合約繞行開關
	緊急通道也必須留證據鏈
	false
	禁止繞行=最保守
	Tier-1 模式/能力旗標（CR_OPEN，P1不升格）：
flag_id
	名稱
	職責
	默認值
	狀態
	enable_agent_mode
	Agent模式開關
	啟用AGENT_ASSIST模式
	false
	CR_OPEN
	enable_t1_mode
	T1模式開關
	啟用隔日沖模式
	false
	CR_OPEN
	ict_hot_swap_enabled
	ICT熱插拔開關
	啟用模組熱插拔
	false
	CR_OPEN
	重要修正：ict_hot_swap_enabled默認值從true修正為false，符合Safe Default原則。
Tier-2 交易域限制旗標（CR_OPEN/P2 Flag）：
flag_id
	名稱
	職責
	默認值
	狀態
	allow_auto_order
	自動下單開關
	控制自動委託
	false
	CR_OPEN
	allow_margin
	融資融券開關
	控制信用交易
	false
	CR_OPEN
	allow_short_selling
	融券賣出開關
	控制放空操作
	false
	P2 Flag
	旗標到期清理政策：
* 每個旗標MUST有退場/到期策略（expiry_policy）
* 超過到期日未處理 → 觸發RADAR_ONLY
* CR_OPEN旗標升格路徑：CR_OPEN → SRS授權申請 → Tier提升
Route-Out：旗標完整Schema見SRS §5.1.2 [SRS-V700-FLAG-GOVERNANCE]
________________


§6.1.2 Flag Usage Matrix
[ANCHOR:ARCH-FLAG-USAGE-MATRIX] [NEW:PATCH-R4-004]
各子系統旗標使用對照表（ARCH MUST NOT自創旗標，只能引用SRS定義）：
子系統
	使用的flag_id
	使用方式
	備註
	CA-WRC
	-
	無
	不受旗標控制
	CA-CORPUS
	-
	無
	不受旗標控制
	CA-DISTILL
	-
	無
	不受旗標控制
	CA-DSL
	-
	無
	不受旗標控制
	CA-METHOD
	-
	無
	不受旗標控制
	CA-BACKTEST
	-
	無
	不受旗標控制
	CA-TA
	-
	無
	不受旗標控制
	CA-SELECT
	-
	無
	不受旗標控制
	CA-TRANSLATE
	allow_xsat
	讀取，控制XSAT輸出
	Tier-0
	CA-WATCH
	-
	無
	不受旗標控制
	CA-EXECUTE
	allow_xsat, require_full_review
	讀取，控制執行決策
	Tier-0
	CA-PERFORM
	-
	無
	不受旗標控制
	CA-UI
	全部
	讀取+顯示
	UI呈現旗標狀態
	CA-COLLAB
	enable_agent_mode
	讀取，控制Agent模式
	Tier-1 (CR_OPEN)
	CA-GOVERN
	全部
	讀取+寫入（唯一）
	旗標管理中心
	架構約束：
* 只有CA-GOVERN可以寫入旗標
* 其他子系統只能讀取旗標狀態
* 嘗試非法寫入 → flag_unauthorized_attempt event + BLOCK_RELEASE
________________


§6.1.3 XDOC-FLAG-CONSISTENCY Gate
[ANCHOR:ARCH-XDOC-FLAG-GATE] [NEW:PATCH-R4-005]
跨文件旗標一致性檢核Gate，確保SRS與ARCH旗標定義不衝突。
檢核規則：
檢核項目
	規則
	失敗處置
	旗標名稱一致
	ARCH flag_id == SRS flag_id
	BLOCK_RELEASE
	默認值一致
	ARCH default == SRS safe_default
	BLOCK_RELEASE
	Tier分層一致
	ARCH tier == SRS tier
	BLOCK_RELEASE
	語義一致
	ARCH描述不得與SRS衝突
	RADAR_ONLY
	Gate觸發時機：
* 文件升級時（ARCH或SRS任一方升級）
* CI/CD Pipeline執行時
* 手動觸發驗證時
檢核腳本（概念）：
# xdoc_flag_consistency_check.sh
diff <(extract_flags ARCH.md) <(extract_flags SRS.md)
# 差異非空 → BLOCK_RELEASE


Fail-Closed行為：
* 檢核失敗 → BLOCK_RELEASE
* 無法執行檢核（腳本錯誤）→ RADAR_ONLY + 人工介入
Route-Out：檢核腳本實作見deliverables/scripts/
________________


§6.2 Degrade Matrix（降級矩陣）
[ANCHOR:ARCH-DEGRADE-MATRIX]
降級規則授權狀態：
Rule ID
	觸發條件
	降級模式
	Fail-Closed行為
	授權狀態
	來源
	DG-AUTO-01
	LLM API連續3次失敗
	FALLBACK_LOCAL
	降級至本地處理
	✅ SRS授權
	SRS §5.2
	DG-AUTO-02
	資料品質Gate失敗
	BLOCK_BACKTEST
	阻斷回測
	✅ SRS授權
	SRS §5.2
	DG-AUTO-03
	Kill Switch觸發
	EMERGENCY_STOP
	全系統暫停
	✅ SRS授權
	SRS §5.2
	DG-DATA-01
	資料源不可用
	CACHE_MODE
	使用快取
	⏳ ARCH補充
	待SRS確認
	DG-EXEC-01
	執行通道異常
	HALT_TRADE
	停止交易
	⏳ ARCH補充
	待SRS確認
	DG-MFA-01
	多因子驗證失敗
	REQUIRE_MANUAL
	要求人工介入
	⏳ ARCH補充
	待SRS確認
	授權政策：
* ✅ SRS授權：已在SRS §5.2明確定義，為MUST規則
* ⏳ ARCH補充：架構層補充規則，待SRS v7.0.1確認後升格
ARCH補充規則處理：
* ARCH補充規則預設為「建議遵守」（SHOULD），非強制（MUST）
* 若ARCH補充規則與SRS衝突，以SRS為準
* ARCH補充規則記錄於CR_OPEN Register（§11.2）
降級模式定義：
模式
	說明
	影響範圍
	NORMAL
	正常運行
	無
	FALLBACK_LOCAL
	降級至本地
	禁用外部API
	BLOCK_BACKTEST
	阻斷回測
	SF-06被阻斷
	EMERGENCY_STOP
	緊急停止
	全部交易暫停
	CACHE_MODE
	快取模式
	使用歷史資料
	HALT_TRADE
	停止交易
	SF-12~17被阻斷
	REQUIRE_MANUAL
	要求人工
	必須HITL確認
	Route-Out：降級規則詳細定義見SRS §5.2
§6.3 Run Config Snapshot
[ANCHOR:ARCH-RUN-CONFIG-SNAPSHOT] [UPDATED:PATCH-R3-011]
最小欄位集合（10欄位，對齊SRS §5.1 SRS-CTRL-TRIO-005）：
欄位
	類型
	說明
	config_version
	string
	配置版本號
	run_id
	string (UUID)
	執行識別碼
	trading_mode
	enum (T0/T1)
	交易模式
	execution_mode
	enum (AGENT_ASSIST/NON_AGENT)
	執行模式
	snapshot_timestamp
	ISO8601
	快照時間
	flag_values
	object
	當前所有旗標值快照
	degrade_mode
	enum
	當前降級模式
	base_pseudocode_fingerprint
	string (SHA-256)
	偽代碼指紋
	input_manifest_hash
	string (SHA-256)
	輸入清單hash
	acml_level
	enum (ACML-0/ACML-1/ACML-2/ACML-3)
	Agent能力等級
	架構層Schema：
{
  "config_version": "string (semver)",
  "run_id": "string (UUID)",
  "trading_mode": "T0|T1",
  "execution_mode": "AGENT_ASSIST|NON_AGENT",
  "snapshot_timestamp": "ISO8601",
  "flag_values": {"flag_id": "value"},
  "degrade_mode": "NORMAL|FALLBACK_LOCAL|BLOCK_BACKTEST|EMERGENCY_STOP",
  "base_pseudocode_fingerprint": "string (SHA-256)",
  "input_manifest_hash": "string (SHA-256)",
  "acml_level": "ACML-0|ACML-1|ACML-2|ACML-3"
}


產生時機：每次Pipeline執行開始時由Orchestrator產生
Route-Out：完整Schema見ICD [SCHEMA-RUN-CONFIG-SNAPSHOT]
________________


§6.3.1 Run Config Snapshot欄位映射（v4.1.1對照）
[ANCHOR:ARCH-SNAPSHOT-V411-MAPPING]
v6.0.0與v4.1.1欄位對應表：
v6.0.0欄位
	v4.1.1欄位
	說明
	config_version
	version_fingerprint
	版本指紋（整體）
	run_id
	run_id
	保持不變
	trading_mode
	-
	新增（T0/T1）
	execution_mode
	-
	新增（NON_AGENT/AGENT_ASSIST）
	snapshot_timestamp
	created_at
	時間戳
	flag_values
	flags
	旗標值
	degrade_mode
	-
	新增（降級狀態）
	base_pseudocode_fingerprint
	spec_version
	規格版本指紋
	input_manifest_hash
	data_version
	資料版本指紋
	acml_level
	-
	新增（Agent能力等級）
	v4.1.1保留欄位處理：
v4.1.1欄位
	v6.0.0處理
	Route-Out
	doc_fingerprints.srs_fingerprint
	合併至base_pseudocode_fingerprint
	ICD [SCHEMA-SNAPSHOT]
	doc_fingerprints.icd_fingerprint
	合併至base_pseudocode_fingerprint
	ICD [SCHEMA-SNAPSHOT]
	bindings.tool_version
	合併至input_manifest_hash
	ICD [SCHEMA-SNAPSHOT]
	bindings.model_version
	合併至input_manifest_hash
	ICD [SCHEMA-SNAPSHOT]
	audit.signature_or_seal
	Route-Out至ICD
	ICD [SCHEMA-SNAPSHOT-AUDIT]
	gates
	Route-Out至SRS
	SRS §5.1
	Route-Out：完整Schema見ICD [SCHEMA-SNAPSHOT]
§6.4 Control Plane Event Log
[ANCHOR:ARCH-CONTROL-PLANE-EVENTS]
控制面必產事件表：
Flag Registry事件（5個）
事件名稱
	觸發時機
	必備欄位
	flag_change_requested
	旗標變更請求
	flag_id, requested_value, requester, timestamp
	flag_change_approved
	旗標變更核准
	flag_id, approved_by, timestamp
	flag_change_applied
	旗標變更生效
	flag_id, old_value, new_value, timestamp
	flag_change_rejected
	旗標變更拒絕
	flag_id, rejected_reason, timestamp
	flag_unauthorized_attempt
	未授權旗標嘗試
	flag_id, requester, timestamp
	Degrade Matrix事件（5個）
事件名稱
	觸發時機
	必備欄位
	degrade_triggered
	降級觸發
	rule_id, trigger_condition, timestamp
	degrade_mode_changed
	降級模式變更
	old_mode, new_mode, timestamp
	degrade_recovered
	降級恢復
	rule_id, recovery_condition, timestamp
	degrade_escalated
	降級升級
	rule_id, escalation_level, timestamp
	degrade_manual_override
	人工覆蓋降級
	operator, override_reason, timestamp
	Run Config Snapshot事件（3個）
事件名稱
	觸發時機
	必備欄位
	snapshot_created
	快照建立
	snapshot_id, run_id, timestamp
	snapshot_validated
	快照驗證
	snapshot_id, validation_status, timestamp
	snapshot_invalidated
	快照失效
	snapshot_id, invalidation_reason, timestamp
	Gate事件（4個）
事件名稱
	觸發時機
	必備欄位
	gate_check_started
	Gate檢查開始
	gate_id, sf_node, timestamp
	gate_check_passed
	Gate檢查通過
	gate_id, sf_node, timestamp
	gate_check_failed
	Gate檢查失敗
	gate_id, sf_node, failure_reason, timestamp
	gate_bypassed
	Gate繞過
	gate_id, bypass_reason, approver, timestamp
	Kill Switch事件（4個）
事件名稱
	觸發時機
	必備欄位
	kill_switch_triggered
	Kill Switch觸發
	kill_type, trigger_reason, timestamp
	kill_switch_acknowledged
	Kill Switch確認
	kill_type, acknowledger, timestamp
	kill_switch_executing
	Kill Switch執行中
	kill_type, execution_progress, timestamp
	kill_switch_completed
	Kill Switch完成
	kill_type, completion_status, timestamp
	事件總計：21個
Route-Out：事件Schema見ICD [SCHEMA-CONTROL-EVENT-*]
§6.5 Intent Specification Architecture
[ANCHOR:ARCH-INTENT-SPEC] [NEW:PATCH-R3-003]
架構定位：intent_spec.json為執行意圖的最小契約。
產生位置：CA-UI（使用者發起）或CA-GOVERN（自動排程）
消費者：Orchestrator
驗證機制：CA-GOVERN Validators在執行前驗證
最小欄位（架構層 - 6欄位）：
{
  "intent_version": "string (semver)",
  "run_id": "string (UUID)",
  "execution_mode": "AGENT_ASSIST|NON_AGENT",
  "requested_tasks": ["task_id[]"],
  "target_subsystems": ["subsystem_id[]"],
  "evidence_manifest_ref": "string (URI)"
}


Route-Out：完整Schema見ICD [SCHEMA-INTENT-SPEC]
________________


§6.6 Validation Hook Architecture
[ANCHOR:ARCH-VALIDATION-HOOK] [NEW:PATCH-R3-003]
架構定位：validation_hook.json定義執行前/中/後的驗證點。
Hook註冊機制：
* 註冊位置：CA-GOVERN Validators Registry
* 註冊時機：Pipeline初始化時
執行時機：
* PRE_EXECUTE：執行前驗證
* IN_EXECUTE：執行中檢查
* POST_EXECUTE：執行後驗證
失敗處理：任一Hook失敗→記錄失敗原因→根據hook.fail_behavior決定（BLOCK/WARN/LOG）
最小欄位（架構層 - 3欄位）：
{
  "run_id": "string (UUID)",
  "hooks": [
    {"hook_id": "string", "type": "PRE|IN|POST", "validator_ref": "string", "fail_behavior": "BLOCK|WARN|LOG"}
  ],
  "rtm_refs": ["rtm_entry_id[]"]
}


Route-Out：完整Schema見ICD [SCHEMA-VALIDATION-HOOK]
________________


§6.7 Evidence References Architecture
[ANCHOR:ARCH-EVIDENCE-REFS] [NEW:PATCH-R3-003]
架構定位：evidence_refs.json為證據集合的最小契約。
收集架構：
* 收集時機：每個SF節點完成時
* 收集者：各子系統（產出evidence_ptr）
* 彙整者：CA-GOVERN Evidence Collector
存放位置：Artifact Store /artifacts/evidence/
查詢機制：
* 索引：evidence_id → evidence_locator
* 查詢入口：CA-UI Evidence Panel / CA-GOVERN Evidence API
最小欄位（架構層 - 10欄位）：
{
  "evidence": [
    {
      "evidence_id": "string (UUID)",
      "evidence_type": "DOCUMENT|CODE|TEST|TRACE|DECISION",
      "title": "string",
      "source": "string (子系統ID)",
      "date": "ISO8601",
      "locator": "string (URI)",
      "hash": "string (SHA-256)",
      "credibility": "HIGH|MEDIUM|LOW"
    }
  ]
}


Route-Out：完整Schema見ICD [SCHEMA-EVIDENCE-REFS]
________________


§6.8 SEM³ Three-Gate Architecture (Complete Definition)
[ANCHOR:ARCH-SEM3-COMPLETE] [NEW:PATCH-059]
本節整合《ΣHybrid — SEM³ Gate & Fidelity Upgrade Blueprint v1.0.0》完整定義。
6.7.1 SEM³ 概述
SEM³為三位一體語意治理體系，確保蒸餾→方法→轉譯全鏈路語意保真。
Gate
	全稱
	職責
	SGF
	Source-Grounded Faithfulness
	來源對齊忠實度：蒸餾產物對原教學語義忠實
	MSC
	Method-Semantics Conformance
	方法語義一致性：方法卡遵循ICT規格與RTM追溯
	TVE
	Translation-Validation Equivalence
	轉譯等價驗證：XS轉譯對參考語義行為等價
	6.7.2 三Gate架構圖
[蒸餾層 SF-03]          [方法層 SF-05/06]        [轉譯層 SF-09/10]
      |                        |                        |
      v                        v                        v
+---------+              +---------+              +---------+
| SEG Gate| ─────────> | MSG Gate| ─────────> | TVG Gate|
|  (SGF)  |              |  (MSC)  |              |  (TVE)  |
+---------+              +---------+              +---------+
      |                        |                        |
      v                        v                        v
FAIL→回蒸餾            FAIL→回方法層         FAIL→禁XS上線
                                                (Radar-only)


6.7.3 SGF Gate（SEG Gate）架構
適用SF節點：SF-03 Distillation
輸入：
* semantics/claims.jsonl
* reports/semantic/*
評估維度：
維度
	說明
	Semantic preservation
	語義保存無漂移
	Claim traceability
	100%可追溯至來源chunks
	No hallucinated content
	無幻覺內容
	Context completeness
	無關鍵遺漏
	輸出Schema（架構層）：
{
  "sem_fidelity_score": "number (0-1)",
  "sem_coverage": "number (0-1)",
  "entailment_min": "number",
  "entailment_mean": "number",
  "qa_coverage": "number",
  "answer_agreement_f1": "number",
  "docvqa_groundedness": "number",
  "self_consistency_divergence": "number",
  "confabulation_flag_rate": "number",
  "conflicts": "array",
  "semantic_ok": "boolean"
}


Fail-Closed：semantic_ok=false → 禁止進入方法層
完整Schema Route-Out: ICD [SCHEMA-SEM3-SGF-REPORT]
6.7.4 MSC Gate（MSG Gate）架構
適用SF節點：SF-05 Method Card Generation
輸入：
* semantics/assertions.jsonl
* tests/sem_exec/* 結果
* reports/method/*
* rtm.csv
評估維度：
維度
	說明
	DbC斷言
	前置/後置/不變式驗證
	規格性質測試
	property-based testing
	RTM雙向覆蓋
	需求↔方法↔測試追溯
	輸出Schema（架構層）：
{
  "dbc_fatal_violations": "integer (must be 0)",
  "spec_property_pass_rate": "number (0-1)",
  "rtm_coverage": "number (0-1)",
  "method_ok": "boolean"
}


Fail-Closed：method_ok=false → 禁止進入轉譯層
完整Schema Route-Out: ICD [SCHEMA-SEM3-MSC-REPORT]
6.7.5 TVE Gate（TVG Gate）架構
適用SF節點：SF-09 XS Translation
輸入：
* 參考實作輸出（偽代碼執行器）
* XS→XQ實跑輸出
* 差分測試腳本
* 同質變形集合
* WT-NA多裁判記錄（選用）
評估維度：
維度
	說明
	等價性
	參考實作 vs XS→XQ行為一致
	同質變形
	幣別/時區/順序變形不變性
	效能
	relay_p95_ms約束（數值見Fitness）
	輸出Schema（架構層）：
{
  "equivalence_mismatch": "integer (must be 0)",
  "equivalence_rate": "number (0-1)",
  "metamorphic_invariant_violations": "integer (must be 0)",
  "translation_ok": "boolean"
}


Fail-Closed：translation_ok=false → 禁止XS上線（允許Radar-only報表）
完整Schema Route-Out: ICD [SCHEMA-SEM3-TVE-REPORT]
6.7.6 SEM³責任矩陣（15子系統）
子系統
	SGF職責
	MSC職責
	TVE職責
	CA-WRC
	-
	-
	-
	CA-CORPUS
	產出claims.jsonl
	-
	-
	CA-DISTILL
	產出蒸餾結果
	-
	-
	CA-METHOD
	-
	產出方法卡
	-
	CA-DSL
	-
	提供原語驗證
	-
	CA-BACKTEST
	-
	-
	參考實作執行
	CA-TA
	-
	-
	-
	CA-TRANSLATE
	-
	-
	產出XS腳本
	CA-WATCH
	-
	-
	-
	CA-EXECUTE
	-
	-
	-
	CA-PERFORM
	-
	-
	-
	CA-GOVERN
	SEG Gate執行
	MSG Gate執行
	TVG Gate執行
	CA-UI
	-
	-
	-
	CA-COLLAB
	RTM提供/Agent協作
	RTM驗證
	-
	註：原CA-AGENT已於v6.0.0-patch-r3整併至CA-COLLAB
6.7.7 S01 Gate + SEM³ 整合
固定鍵位（加入acceptance_map.json）：
{
  "semantic_ok": true,
  "method_ok": true,
  "translation_ok": true,
  "sem_fidelity_score_min": "number (Candidate)",
  "sem_coverage_min": "number (Candidate)",
  "spec_property_pass_rate_min": "number (Candidate)",
  "rtm_coverage_min": "number (Candidate)",
  "equivalence_rate_min": "number (Candidate)"
}


門檻狀態：上述數值為CANDIDATE（warning only），升級為MUST需SRS變更請求。
Route-Out：具體數值見Fitness [LBP-E-SEM3-THRESHOLDS]
6.7.8 RACI（三Gate分工）
Gate
	R（執行者）
	A（當責者）
	C（諮詢者）
	I（知會者）
	SEG(SGF)
	TriRAG蒸餾執行
	資料治理
	WT-NA多裁判
	方法/XS團隊
	MSG(MSC)
	方法/分析團隊
	產品負責
	TriRAG與測試
	XS團隊
	TVG(TVE)
	XS/整合團隊
	技術負責
	方法團隊
	治理
	6.7.9 Observability事件介面
事件
	說明
	seg.claims.loaded
	SEG claims載入完成
	seg.gate.failed
	SEG Gate驗證失敗
	method.dbc.violation
	MSC DbC斷言違反
	translation.equiv.mismatch
	TVE等價性不符
	translation.ok
	TVE Gate通過
	事件欄位：ts, level, component, artifact_ptr, summary, evidence_ptr[]
6.7.10 Route-Out彙總
目標
	錨點
	內容
	ICD
	[SCHEMA-SEM3-SGF-REPORT]
	SGF報表完整Schema
	ICD
	[SCHEMA-SEM3-MSC-REPORT]
	MSC報表完整Schema
	ICD
	[SCHEMA-SEM3-TVE-REPORT]
	TVE報表完整Schema
	ICD
	[SCHEMA-SEM3-REGISTRY]
	SEM³配置Registry Schema
	SRS
	§0.4 [SRS-V700-GATE-SEM3]
	SEM³ Gate驗收條件
	Fitness
	[LBP-E-SEM3-THRESHOLDS]
	門檻數值定義
	ADR
	[ADR-SEM3-01]
	三Gate治理模型採用決策
	ADR
	[ADR-SEM3-02]
	XS採Translation-Validation決策
	________________


§7 Key Architectural Decisions
[ANCHOR:ARCH-KEY-DECISIONS]
Decision ID
	決策
	結論
	ADR指針
	AD-001
	子系統數量
	15（刪除CA-FIREWALL）
	ADR-001
	AD-002
	SF-11定位
	Gate（非子系統）
	ADR-002
	AD-003
	Agent模式
	雙模（NON_AGENT/AGENT_ASSIST）
	ADR-003
	AD-004
	T0/T1模式
	雙線並行
	ADR-004
	AD-005
	Control Plane
	6旗標配置
	ADR-005
	AD-006
	CA-UI定位
	單一入口
	ADR-006
	AD-007
	SEM³採用
	三Gate治理
	ADR-SEM3-01
	AD-008
	ICT熱插拔
	雙鍵綁定
	ADR-ICT-01
	Route-Out: ADR詳細記錄見ADR文件庫
________________


§7.5 Six Core Objectives Architecture Support
[ANCHOR:ARCH-SIX-OBJECTIVES] [UPDATED:PATCH-R3-001] (原FIVE-OBJECTIVES升級)
《SRS §2.2》定義的六大核心目標（G1-G6），本節說明其架構支撐機制。
目標ID
	目標名稱
	SRS錨點
	G1
	操作複雜度下降
	SRS-GOAL-G1-001
	G2
	可觀測性上升
	SRS-GOAL-G2-001
	G3
	LLM工廠效率
	SRS-GOAL-G3-001
	G4
	策略效能改善
	SRS-GOAL-G4-001
	G5
	風險控制
	SRS-GOAL-G5-001
	G6
	ICT模組熱插拔
	SRS-GOAL-G6-001
	7.5.1 G1: 操作複雜度下降（Dev Velocity）
架構支撐機制：
機制
	實現子系統
	關鍵架構元件
	RTM自動生成
	CA-COLLAB
	RTM Builder構件
	Schema自動驗證
	CA-GOVERN
	Schema Validator
	熱插拔測試
	CA-METHOD
	ICT Test Harness
	RTM在架構中的落地：
* 位置：CA-COLLAB產出，存放於/deliverables/rtm/
* 產生：自動從spec_map.csv + test_results生成
* 消費：CA-GOVERN驗證、CA-UI展示
* 更新觸發：任何spec/test變更
7.5.2 G2: 可觀測性上升（Observability）
架構支撐機制：
機制
	實現子系統
	關鍵架構元件
	三通道架構
	CA-PERFORM
	Metrics/Events/Logs
	自動化trace對齊
	Automation Assistant
	Trace Sync
	儀表板
	CA-UI
	Observability Dashboard
	required_event_logs
	各子系統
	Event Log標準介面
	自動化trace對齊架構：
* Automation Assistant產出的trace.zip包含時間戳
* CA-PERFORM的metrics以相同時間軸對齊
* CA-UI儀表板可做時間軸聯動展示
7.5.3 G3: LLM工廠效率（LLM Factory Stability）
架構支撐機制：
機制
	實現子系統
	關鍵架構元件
	evals架構
	Evals Runner
	Regression Test Engine
	三角仲裁
	LLM Factory
	Arbiter Module
	fallback鏈
	CA-GOVERN
	Fallback Controller
	evals架構位置：見§3.2.9 [ANCHOR:ARCH-EVALS-RUNNER]
仲裁規則執行架構：見§4.17 [ANCHOR:ARCH-ARBITER]
7.5.4 G4: 策略效能改善
[ANCHOR:ARCH-G4-STRATEGY] [NEW:PATCH-R3-001]
架構支撐機制：
機制
	實現子系統
	關鍵架構元件
	策略績效雙跑道
	CA-PERFORM
	Track-A Metrics Engine
	回測過擬合防線
	CA-BACKTEST
	4大防線架構
	MethodCard版控
	CA-METHOD
	MethodCard Registry
	策略效能追蹤架構：
* 計算位置：CA-PERFORM Metrics Engine
* 指標：勝率/報酬比/夏普比/風險調整報酬
* 報表：/reports/fitness/strategy.json
* 消費者：CA-UI Dashboard、CA-GOVERN Alert
Route-Out：見§4.13.1 [ANCHOR:ARCH-CA-PERFORM-TRACKA]
7.5.5 G5: 風險控制
[ANCHOR:ARCH-G5-RISK] [NEW:PATCH-R3-001]
架構支撐機制：
機制
	實現子系統
	關鍵架構元件
	時間窗不變量
	CA-WATCH/CA-EXECUTE
	Time Window Validator
	三軸約束檢查
	CA-GOVERN
	TWMS Axis Checker
	Kill Switch
	CA-EXECUTE
	Emergency Stop Controller
	降級矩陣
	CA-GOVERN
	Degrade Matrix Engine
	風險控制架構流程：
[信號產生] → [時間窗檢查] → [流動性檢查] → [交易規則檢查]
                                                ↓
              [任一失敗] → [Fail-Closed] → [阻斷執行]
                                                ↓
              [全部通過] → [進入CA-EXECUTE]


Route-Out：見§8.4 [ANCHOR:ARCH-TIME-WINDOW-CONSTRAINTS]
7.5.6 G6: ICT模組熱插拔
[ANCHOR:ARCH-G6-ICT] [NEW:PATCH-R3-001]
架構支撐機制：
機制
	實現子系統
	關鍵架構元件
	Technique Registry
	CA-GOVERN
	ICT Registry
	雙鍵綁定
	ICT Hot-Swap
	slot_key + methodcard_key
	四路徑切換
	ICT Hot-Swap
	DISABLED/REPLACED/ROLLBACK/A-B TEST
	台股在地化
	CA-DSL
	MarketProfile + ICT Localization
	ICT熱插拔架構位置：見§4.18 [ANCHOR:ARCH-ICT-HOTSWAP]
架構約束：
* 切換原子性：任何切換操作需原子完成或全部回滾
* Fail-Closed：切換失敗→維持舊版 + 產生ICT_HOTSWAP_FAILED事件
* 版本追蹤：所有切換歷史記錄於hotswap_log.jsonl
7.5.7 Human-Minimized（人工最小化 - 補充）
架構支撐機制：
機制
	實現子系統
	關鍵架構元件
	Automation Assistant
	CA-UI
	Playwright Runner
	attended-first策略
	CA-GOVERN
	Mode Controller
	自動化驗證記錄
	Artifact Store
	Evidence Archive
	Automation Assistant架構位置：見§3.4 [ANCHOR:ARCH-AUTOMATION-ASSISTANT]
Route-Out：驗收條件見SRS §2.2 [SRS-V700-CORE-GOALS]
________________


§8 Major Constraints & Quality Drivers
[ANCHOR:ARCH-CONSTRAINTS]
§8.1 Fail-Closed Principle
定義：系統在不確定情況下選擇保守行為。
適用範圍：
* Gate驗證失敗 → 阻斷流程
* 資料異常 → 暫停處理
* API失敗 → 降級路徑
________________


§8.4 時間窗不變量（Time Window Invariants）
[ANCHOR:ARCH-TIME-WINDOW-INVARIANTS]
INV-ID
	時間範圍
	規則
	影響子系統
	Fail-Closed行為
	事件日誌
	INV-TWSE-PREOPEN
	08:30-09:00
	禁止新倉
	CA-WATCH, CA-EXECUTE
	拒絕訂單
	inv_preopen_blocked
	INV-TWSE-REGULAR
	09:00-13:25
	正常交易
	全部
	-
	-
	INV-T0-NEWPOS-CUTOFF
	13:10
	T0禁止新倉
	CA-EXECUTE
	新倉→Fail-Closed
	inv_t0_newpos_blocked
	INV-T0-FORCE-CLOSE
	13:20
	T0強制平倉
	CA-EXECUTE
	未平倉→強制清倉
	inv_t0_force_close
	INV-TWSE-ROD-ONLY
	13:25-13:30
	僅ROD委託
	CA-EXECUTE
	非ROD→拒絕
	inv_rod_only
	INV-TWSE-CLOSE
	13:30
	收盤
	CA-WATCH, CA-EXECUTE
	禁止委託
	inv_market_closed
	INV-T1-OVERNIGHT
	次日10:00前
	T1隔夜風控
	CA-EXECUTE
	未完成風控→告警
	inv_t1_overnight_risk
	T0/T1差分：
* T0（當沖）：適用INV-T0-NEWPOS-CUTOFF、INV-T0-FORCE-CLOSE
* T1（隔日沖）：適用INV-T1-OVERNIGHT，不適用T0專屬規則
架構責任分配：
職責
	負責子系統
	產物
	時間窗檢查
	CA-WATCH + CA-EXECUTE
	time_window_check_log.jsonl
	規則裁決
	CA-GOVERN
	degrade_event.jsonl
	強制執行
	CA-EXECUTE
	execute_forced_close.jsonl
	Route-Out：時序SLO數值見SRS §5.x / LBP-E(Fitness)
§8.5 Kill Switch架構時序
[ANCHOR:ARCH-KILL-SWITCH-SEQUENCE]
Kill Switch觸發架構（時序階段）：
階段
	說明
	負責子系統
	產物
	T0
	觸發
	CA-GOVERN
	kill_switch_triggered event
	T1
	檢測
	CA-GOVERN
	risk_detection_log
	T2
	記錄
	CA-GOVERN
	kill_switch_log.jsonl
	T3
	廣播
	CA-GOVERN
	kill_broadcast_event
	T4
	開始清倉
	CA-EXECUTE
	force_close_initiated
	T5
	完成清倉
	CA-EXECUTE
	force_close_completed
	架構責任分配：
* 觸發裁決：CA-GOVERN（唯一權威）
* 廣播機制：CA-GOVERN → CA-UI + CA-WATCH + CA-EXECUTE
* 執行清倉：CA-EXECUTE（必須響應）
* 狀態監控：CA-UI（必須顯示）
Kill Switch類型：
類型
	觸發條件
	降級模式
	架構行為
	KILL-1
	資料/訊號不可信
	HALT
	停止新倉+人工介入
	KILL-2
	風控規則觸發
	EMERGENCY_STOP
	停止新倉+執行停損
	KILL-3
	系統異常
	FREEZE
	全系統暫停+人工介入
	必備工件：
* kill_switch_log.jsonl（必備欄位：trigger_type, trigger_time, trigger_reason, operator, status）
Route-Out：時序SLO數值見SRS §5.x / LBP-E(Fitness)
§8.5 Attended-First Architecture Strategy
[ANCHOR:ARCH-ATTENDED-FIRST] [NEW:PATCH-056]
架構策略定位：Attended-first為架構級策略（非僅風險緩解），定義系統預設運行模式。
模式維度定義：
模式
	定義
	適用場景
	attended
	人工監督 + 系統執行 + 即時確認
	正常運營、高風險操作
	unattended
	系統自動執行 + 事後審計
	已驗證流程、低風險批次
	架構約束：
約束
	說明
	實現子系統
	預設attended
	系統啟動預設attended模式
	CA-GOVERN
	人工確認點
	SF-11 HITL必須人工確認
	CA-WATCH
	自動化監督
	Automation Assistant受attended約束
	CA-UI
	模式鎖定
	高風險時段禁止unattended
	CA-GOVERN
	attended模式架構約束：
* SF-11強制人工：HITL節點不可bypass
* 關鍵操作確認：訂單送出需人工確認
* 即時回饋：操作結果即時通知操作者
* 介入權限：操作者可隨時中止任何流程
unattended模式前置條件：
條件
	說明
	驗證方式
	連續成功
	連續N次attended執行成功
	紀錄查詢
	證據完整
	evidence_chain完整無缺
	自動檢查
	人工簽核
	授權人員簽核
	簽核紀錄
	風險評估
	風險等級≤MEDIUM
	風控評估
	Route-Out：N值與風險等級定義見SRS §3.18 [SRS-V700-FR-MODE]
降級路徑：
* unattended執行異常 → 強制降級attended
* 無需人工同意，系統自動執行
* 降級事件寫入Event Log
________________


§8.6 Degrade Rules Architecture
[ANCHOR:ARCH-DEGRADE-RULES]
降級規則彙總：
規則ID
	觸發場景
	降級行為
	恢復條件
	DG-AUTO-01
	Automation異常
	fallback手動WT-NA
	異常排除+人工確認
	DG-AUTO-02
	MFA/Captcha
	強制人工介入
	人工完成驗證
	DG-LLM-01
	LLM不可用
	降級至manual/cache
	LLM恢復
	DG-DATA-01
	資料源異常
	暫停新信號
	資料恢復
	DG-EXEC-01
	執行異常
	Kill Switch
	人工確認
	________________


§8.7 台股微結構三軸約束架構
[ANCHOR:ARCH-TWMS-AXIS] [NEW:PATCH-R5-004]
架構定位：三軸約束為台股交易的強制性合規架構，所有交易決策MUST通過三軸檢查。
SRS對齊：SRS §3.8 [SRS-V700-TWMS-AXIS] 定義三軸約束需求（SRS-FR-TWMS-AXIS-001~003）。
三軸約束總覽：
軸
	約束類型
	檢查範圍
	Gate Policy
	軸一
	時間窗約束
	交易時段合規性
	EXECUTE_DISABLED
	軸二
	流動性約束
	委託量/價格合理性
	EXECUTE_DISABLED
	軸三
	交易規則約束
	T0/T1/融資融券合規
	EXECUTE_DISABLED
	三軸檢查架構圖：
┌─────────────────────────────────────────────────────────────────┐
│                  三軸約束檢查架構                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  [交易信號]                                                      │
│       │                                                         │
│       ↓                                                         │
│  ┌──────────────────┐                                           │
│  │ TWMS Axis Checker│ (CA-GOVERN)                               │
│  └──────────────────┘                                           │
│       │                                                         │
│       ├────────────────────────────────────────────────┐        │
│       │                    │                           │        │
│       ↓                    ↓                           ↓        │
│  ┌─────────┐         ┌─────────┐               ┌─────────┐     │
│  │ 軸一    │         │ 軸二    │               │ 軸三    │     │
│  │ 時間窗  │         │ 流動性  │               │ 交易規則│     │
│  │ Checker │         │ Checker │               │ Checker │     │
│  └─────────┘         └─────────┘               └─────────┘     │
│       │                    │                           │        │
│       └────────────────────┼───────────────────────────┘        │
│                            ↓                                    │
│                    ┌───────────────┐                            │
│                    │ 三軸裁決整合   │                            │
│                    │ (AND邏輯)     │                            │
│                    └───────────────┘                            │
│                            │                                    │
│              ┌─────────────┴─────────────┐                      │
│              ↓                           ↓                      │
│     ┌────────────┐              ┌────────────┐                  │
│     │ 全PASS     │              │ 任一FAIL   │                  │
│     │ → 允許執行 │              │ → Fail-Closed│                 │
│     └────────────┘              └────────────┘                  │
│                                        ↓                        │
│                           ┌────────────────────┐                │
│                           │ twms_axis_check    │                │
│                           │ _report.json       │                │
│                           └────────────────────┘                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘


§8.7.1 軸一：時間窗約束
[ANCHOR:ARCH-TWMS-AXIS1]
架構引用：詳細時間窗不變量見§8.4 [ANCHOR:ARCH-TIME-WINDOW-INVARIANTS]
時間窗約束檢查點：
檢查點ID
	時間範圍
	約束規則
	違反處理
	AXIS1-001
	08:30-09:00
	禁止新倉
	拒絕委託
	AXIS1-002
	09:00-13:10
	正常交易（T0可新倉）
	-
	AXIS1-003
	13:10-13:20
	T0禁止新倉/加碼，僅可減倉
	攔截新倉委託
	AXIS1-004
	13:20-13:25
	強制清倉
	產生強制平倉指令
	AXIS1-005
	13:25-13:30
	ROD-only
	非ROD委託拒絕
	時間窗檢查輸出（架構層）：
{
  "axis": "axis_1_time_window",
  "verdict": "PASS|FAIL",
  "check_time": "ISO8601",
  "current_phase": "PREOPEN|REGULAR|T0_CUTOFF|FORCE_CLOSE|ROD_ONLY|CLOSED",
  "violations": []
}


§8.7.2 軸二：流動性約束
[ANCHOR:ARCH-TWMS-AXIS2]
流動性約束檢查點（對齊SRS §3.8 軸二定義）：
檢查點ID
	約束規則
	門檻值
	違反處理
	AXIS2-001
	單筆委託量限制
	≤日均量1%
	拆單或拒絕
	AXIS2-002
	委託價格限制
	≤漲跌停±7%邊界
	拒絕或警告
	AXIS2-003
	流動性不足警告
	委託量>當日成交量10%
	警告（不阻斷）
	流動性數據來源：
數據項
	來源
	更新頻率
	缺失處理
	avg_daily_volume
	CA-TA計算
	每日盤後
	使用20日均量
	today_volume
	即時行情
	即時
	FAIL（無法判斷）
	limit_up/limit_down
	交易所公告
	每日盤前
	FAIL（無法判斷）
	流動性檢查輸出（架構層）：
{
  "axis": "axis_2_liquidity",
  "verdict": "PASS|FAIL|WARNING",
  "check_time": "ISO8601",
  "symbol": "string",
  "violations": []
}


§8.7.3 軸三：交易規則約束
[ANCHOR:ARCH-TWMS-AXIS3]
交易規則約束檢查點（對齊SRS §3.8 軸三定義）：
檢查點ID
	約束規則
	檢查內容
	違反處理
	AXIS3-001
	T0當沖規則
	當日開倉必須當日平倉
	強制清倉
	AXIS3-002
	T1隔日沖規則
	可持倉過夜但需隔日平倉
	隔日提醒
	AXIS3-003
	融資資格檢查
	帳戶是否有融資權限
	拒絕融資委託
	AXIS3-004
	融券資格檢查
	標的是否可融券/帳戶權限
	拒絕融券委託
	AXIS3-005
	當沖資格檢查
	標的是否在可當沖清單
	降級為T1
	AXIS3-006
	零股當沖禁止
	零股不得當沖
	拒絕零股當沖
	交易規則檢查輸出（架構層）：
{
  "axis": "axis_3_trading_rules",
  "verdict": "PASS|FAIL",
  "check_time": "ISO8601",
  "trading_mode": "T0_DAYTRADE|T1_SWING",
  "violations": []
}


§8.7.4 三軸檢查協調器（TWMS Axis Checker）
[ANCHOR:ARCH-TWMS-CHECKER]
架構定位：TWMS Axis Checker為三軸約束的統一協調器，位於CA-GOVERN。
三軸裁決邏輯：
軸一結果
	軸二結果
	軸三結果
	overall_verdict
	Gate Policy
	PASS
	PASS
	PASS
	PASS
	允許執行
	PASS
	PASS
	FAIL
	FAIL
	EXECUTE_DISABLED
	PASS
	FAIL
	PASS
	FAIL
	EXECUTE_DISABLED
	PASS
	WARNING
	PASS
	WARNING
	RADAR_ONLY
	FAIL
	*
	*
	FAIL
	EXECUTE_DISABLED
	twms_axis_check_report.json Schema（架構層）：
{
  "report_id": "string (UUID)",
  "strategy_id": "string",
  "timestamp": "ISO8601",
  "axis_1_time_window": {"verdict": "PASS|FAIL", "violations": []},
  "axis_2_liquidity": {"verdict": "PASS|FAIL|WARNING", "violations": []},
  "axis_3_trading_rules": {"verdict": "PASS|FAIL", "violations": []},
  "overall_verdict": "PASS|FAIL|WARNING",
  "gate_policy": "EXECUTE_DISABLED|RADAR_ONLY|BLOCK_RELEASE"
}


Fail-Closed行為（對齊SRS-FR-TWMS-AXIS-003）：
* overall_verdict=FAIL → gate_policy=EXECUTE_DISABLED（禁止執行）
* overall_verdict=WARNING → gate_policy=RADAR_ONLY（僅觀察）
* overall_verdict=PASS → 允許進入CA-EXECUTE
TWMS Axis Checker實現位置：
元件
	歸屬子系統
	職責
	TWMS Axis Checker
	CA-GOVERN
	協調三軸檢查
	Time Window Validator
	CA-GOVERN
	軸一檢查
	Liquidity Checker
	CA-SELECT
	軸二檢查
	Trading Rule Checker
	CA-EXECUTE
	軸三檢查
	Route-Out：
* 完整Schema：ICD [SCHEMA-TWMS-AXIS-CHECK]
* 驗收條件：SRS §3.8 [SRS-V700-TWMS-AXIS]
* Gate Policy定義：§6.0.1 [ANCHOR:ARCH-GATE-POLICY]
________________


§9 Agent SKILLS Dual-Mode Architecture
[DEPRECATED:已整併至§4.14 CA-COLLAB]
本節內容已於v6.0.0-patch-r3整併至§4.14 CA-COLLAB。以下保留摘要供交叉參照。
§9.1 Agent Mode Switch
[ANCHOR:ARCH-AGENT-MODE-LEGACY]
詳細架構：見§4.14.10 [ANCHOR:ARCH-AGENT-MODE]
雙模定義：
模式
	代碼
	說明
	NON_AGENT
	0
	傳統手動模式（預設）
	AGENT_ASSIST
	1
	AI輔助模式
	切換觸發器：
觸發類型
	條件
	動作
	啟用Agent
	enable_agent_mode=true + 人工確認
	NON_AGENT→AGENT_ASSIST
	停用Agent
	人工停用/異常觸發
	AGENT_ASSIST→NON_AGENT
	切換約束：
* 切換需原子事務
* 切換記錄寫入審計日誌
* 異常時自動回退NON_AGENT
________________


§9.2 Skills Registry Slot
[ANCHOR:ARCH-SKILLS-REGISTRY]
Skills定義（架構層）：
Skill ID
	能力
	約束
	SKILL_SEARCH
	資訊檢索
	白名單來源
	SKILL_SUMMARIZE
	摘要生成
	長度限制
	SKILL_TRANSLATE
	語言轉換
	語言對限制
	SKILL_ANALYZE
	資料分析
	輸出格式限制
	Route-Out：Skills完整定義見ICD [SCHEMA-AGENT-SKILLS]
________________


§9.3 Agent Guardrails
[ANCHOR:ARCH-AGENT-GUARDRAILS]
禁止清單（4項，CR_OPEN_PTR待SRS授權）：
禁止項
	說明
	CR_OPEN
	GUI自動化
	禁止Agent執行GUI操作
	CR_OPEN:SRS-AGENT-001
	直接交易
	禁止Agent直接下單
	CR_OPEN:SRS-AGENT-002
	非白名單網路
	禁止非白名單網路存取
	CR_OPEN:SRS-AGENT-003
	寫入SSOT
	禁止Agent直接寫入SSOT
	CR_OPEN:SRS-AGENT-004
	________________


§13 Route-Out Map（唯一指針表）
[ANCHOR:ARCH-ROUTE-OUT-COMPLETE]
完整Route-Out Map見§0.4 [ANCHOR:ARCH-ROUTE-OUT-MAP]
________________


§11 Drift/Conflict Ledger
[ANCHOR:ARCH-CONFLICT-LEDGER]
§11.1 結構變更記錄
變更ID
	變更內容
	來源
	版本
	CHG-001
	CA-FIREWALL刪除
	升級藍圖v1.1.0
	v6.0.0
	CHG-002
	SF-11定位為Gate
	升級藍圖v1.1.0
	v6.0.0
	CHG-003
	6旗標配置
	SRS v7.0.0
	v6.0.0
	CHG-004
	SEM³三Gate整合
	SEM³ Blueprint v1.0.0
	v6.0.0-patch-r2
	CHG-005
	5關鍵構件補齊
	審查修補方案v2.0.0
	v6.0.0-patch-r2
	CHG-006
	CA-AGENT整併至CA-COLLAB
	SRS審查報告
	v6.0.0-patch-r3
	CHG-007
	Six Core Objectives（G1-G6）
	SRS審查報告
	v6.0.0-patch-r3
	CHG-008
	控制面三件套架構
	SRS審查報告
	v6.0.0-patch-r3
	CHG-009
	Agent雙模8條需求完整架構
	SRS審查報告
	v6.0.0-patch-r3
	CHG-010
	MarketProfile SSOT架構
	SRS審查報告
	v6.0.0-patch-r3
	CHG-011
	台股三軸約束架構
	SRS審查報告
	v6.0.0-patch-r3
	CHG-012
	§4.17/§4.18重新編號
	子系統整併
	v6.0.0-patch-r3
	CHG-013
	JobCard完整架構(§5.6)
	SRS審查
	v6.0.0-patch-r5
	CHG-014
	WebTools-NA獨立架構(§4.19)
	SRS審查
	v6.0.0-patch-r5
	CHG-015
	台股三軸約束統一架構(§8.7)
	SRS審查
	v6.0.0-patch-r5
	§11.2 CR_OPEN Register
CR_OPEN_ID
	主題
	目標文件
	優先級
	CR_OPEN:ICD-T1-001~004
	T1工件Schema
	ICD
	BLOCK_RELEASE
	CR_OPEN:ICD-AGENT-001
	Agent工件Schema
	ICD
	BLOCK_RELEASE
	CR_OPEN:ICD-UI-CONTRACT
	CA-UI介面契約
	ICD
	BLOCK_RELEASE
	CR_OPEN:SRS-FLAG-EXT
	Flag擴充授權
	SRS
	RADAR_ONLY
	CR_OPEN:SRS-AGENT-GUARD
	Agent Guardrails授權
	SRS
	RADAR_ONLY
	CR_OPEN:ICD-AUTOMATION
	Automation工件Schema
	ICD
	BLOCK_RELEASE
	CR_OPEN:ICD-ARBITER
	Arbiter決策Schema
	ICD
	BLOCK_RELEASE
	緩解措施：Fail-Closed - 相關功能在Schema定義前禁用
________________


§11.5 P1 Minimum Viable Closure Architecture Mapping
[ANCHOR:ARCH-P1-MINIMUM-CLOSURE] [NEW:PATCH-058]
《增補升級方案v2》§4.9列出7項P1必做修補，本節說明其架構支撐。
7項修補架構對齊：
項目
	修補內容
	架構支撐位置
	交付工件
	1. RTM-B覆蓋率審查
	需求追溯矩陣完整性
	CA-COLLAB RTM Builder
	rtm_b_gap_report.md
	2. SRS入口條款
	審查KPI要求
	CA-GOVERN Review Gate
	SRS.REVIEWKPI.7
	3. LBP-A增補
	Automation Assistant工件
	§3.4 [ANCHOR:ARCH-AUTOMATION-ASSISTANT]
	automation_trace/*
	4. LBP-B補強
	ICD完整版
	Route-Out: ICD
	ICD v4.1.0+
	5. 降級規則
	DG-AUTO-01/02
	§8.6 [ANCHOR:ARCH-DEGRADE-RULES]
	degrade_matrix.json
	6. Self-Check
	Mini-P1 ACC Suite
	CA-GOVERN Acceptance Runner
	acc_suite_results.json
	7. SEM³
	架構級驗證框架
	§6.7 [ANCHOR:ARCH-SEM3-COMPLETE]
	sem3_report.json
	架構支撐詳情：
1. RTM-B覆蓋率審查架構：
* 產生：CA-COLLAB從spec_map.csv自動生成
* 驗證：CA-GOVERN檢查coverage_rate（數值見Fitness）
* 輸出：/deliverables/rtm/rtm_b_gap_report.md
2. SRS入口條款架構：
* 檢查點：Release前CA-GOVERN執行
* 驗證：7項REVIEWKPI全部PASS
* 輸出：/reports/review/srs_review_kpi.json
3. LBP-A增補架構：
* 位置：§3.4 Automation Assistant完整說明
* 工件：auto_trace/video/screenshot/action_log
4. LBP-B補強架構：
* Route-Out：ICD [CONTRACT-], [SCHEMA-]
* 版本：ICD v4.1.0+需補齊所有CR_OPEN
5. 降級規則架構：
* 位置：§8.6 [ANCHOR:ARCH-DEGRADE-RULES]
* 規則：DG-AUTO-01（自動化異常）、DG-AUTO-02（MFA/Captcha）
6. Self-Check架構：
* 位置：CA-GOVERN Acceptance Runner模組
* 執行：自動化驗收測試套件
* 輸出：/reports/acceptance/acc_suite_results.json
7. SEM³架構：
* 位置：§6.7 [ANCHOR:ARCH-SEM3-COMPLETE]
* 三Gate：SGF/MSC/TVE完整定義
Route-Out：驗收條件見SRS §3.22 [SRS-V700-FR-P1-CLOSURE]
________________


Appendices
APPX-A Anchor Registry
[ANCHOR:ARCH-APPX-A-ANCHORS]
錨點總數: 約150個（含新增Patch錨點）
錨點類別
	數量
	範例
	§0 Preflight
	15
	ARCH-PREFLIGHT, ARCH-CANDIDATE-FENCE
	§1-2 Overview
	8
	ARCH-PURPOSE, ARCH-VOCABULARY
	§3 Views
	20
	ARCH-ORCHESTRATOR, ARCH-AUTOMATION-ASSISTANT
	§4 Subsystems
	25
	ARCH-CA-*, ARCH-ICT-HOTSWAP, ARCH-ARBITER
	§5 SF
	12
	ARCH-SF-*, ARCH-EVIDENCE-CHAIN
	§6 Control
	18
	ARCH-FLAG-REGISTRY, ARCH-SEM3-COMPLETE
	§7 Decisions
	8
	ARCH-KEY-DECISIONS, ARCH-FIVE-OBJECTIVES
	§8 Constraints
	12
	ARCH-TIME-WINDOW-CONSTRAINTS, ARCH-ATTENDED-FIRST
	§9 Agent
	6
	ARCH-AGENT-MODE, ARCH-SKILLS-REGISTRY
	§10-11
	8
	ARCH-CONFLICT-LEDGER, ARCH-P1-MINIMUM-CLOSURE
	APPX
	10
	ARCH-APPX-*, ARCH-P0-TASK-MAPPING
	________________


APPX-B Crosswalk/Legacy
[ANCHOR:ARCH-APPX-B-CROSSWALK]
舊版元素
	v6.0.0-patch-r2對應
	狀態
	CA-FIREWALL
	已刪除
	功能全面廢棄
	v5.2.0 §4.16 CA-FIREWALL
	§11.1 CHG-001（變更記錄）
	永久刪除
	v4.1.1 ICT熱插拔
	§4.19 [ARCH-ICT-HOTSWAP]
	補回+增強
	v4.1.1 時間窗表
	§8.4 [ARCH-TIME-WINDOW-CONSTRAINTS]
	補回
	v4.1.1 ICRU能力鏈
	§5.3.2 [ARCH-EVIDENCE-CHAIN]
	補回
	v4.1.1 可觀測性
	§7.5.4
	補回
	Technique Inventory位置：/spartoi_flow/technique_inventory/technique_inventory.jsonl
________________


APPX-B.2 CA-FIREWALL Sunset Rationale
[ANCHOR:ARCH-FIREWALL-SUNSET]
CA-FIREWALL子系統廢棄說明：
原職責（v4.1.1/v5.2.0）：
* Legacy邊界防火牆
* 確保Legacy內容僅作Evidence，不升格為Norm
* 防止P0階段舊有內容污染P1規格閉環
廢棄理由：
1. 上位裁決：SRS v7.0.0 §2.3 明確不包含CA-FIREWALL
2. 功能替代：《Candidate處置規則_v2》H0-H8規則完整覆蓋原CA-FIREWALL職責
3. 架構簡化：16子系統→15子系統，減少維護負擔
功能遷移對照：
原CA-FIREWALL功能
	遷移至
	定位點
	Legacy內容隔離
	Candidate處置規則_v2 H1-H4
	§4.1 Legacy Policy
	Evidence-Only政策
	Candidate處置規則_v2 H5-H6
	§5.1 Evidence Schema
	Norm升格Gate
	Candidate處置規則_v2 H7-H8
	§6.1 Promotion Gate
	變更記錄：CHG-001（§11.1）
Route-Out：Candidate處置規則_v2
APPX-C Build Report
[ANCHOR:ARCH-APPX-C-BUILD-REPORT]
項目
	數值/狀態
	版本
	v6.0.0-patch-r2
	產出日期
	2026-01-08
	子系統數量
	15
	總錨點數
	~150
	升級Patch總數
	65（37 Primary + 28 Sub）
	SEM³整合狀態
	✅ 完成（整合ΣHybrid Blueprint）
	CR_OPEN數量
	7項
	Anti-Drift檢核
	✅ 全部PASS
	Patch執行確認：
Phase
	Patch範圍
	狀態
	證據位置
	Phase 1
	PATCH-001,052~054,011-R,012-R
	✅
	§3.2, §4.19
	Phase 2
	PATCH-059,009
	✅
	§6.7
	Phase 3
	PATCH-043-R,055~058
	✅
	§4.18, §7.5, §8.5, §11.5
	Phase 4
	PATCH-002,003,024-R,025-R,028
	✅
	§5.3.2, §8.4, §4.2.5, §4.7.5
	Phase 5
	PATCH-004~007,010,013~034
	✅
	§4各子系統
	Phase 6
	PATCH-035,040,063,064,036~039
	✅
	§0.3.5, APPX-D
	Phase 7
	PATCH-046~051,065
	✅
	§3.2.10
	Phase 8
	ARCH-PATCH-r3-001~020
	✅
	全量修補方案
	APPX-C.2 Regression Checklist（回歸檢查清單）
[ANCHOR:ARCH-REGRESSION-CHECKLIST]
本ARCH文件的可驗收回歸檢查清單（20項）：
#
	檢查項目
	驗證方法
	預期結果
	狀態
	1
	正文Legacy token = 0
	grep正文
	0命中
	✅
	2
	SF-18~SF-31仍Reserved
	定位§5.2
	標記Reserved
	✅
	3
	APPX-A Crosswalk存在
	grep "APPX-A"
	可定位
	✅
	4
	Authority Stack含SFHB優先規則
	定位§0.2
	可定位
	✅
	5
	Conflict Ledger條目模板存在
	定位APPX-E
	可定位
	✅
	6
	Candidate Register有authority_source
	定位APPX-F
	每列有值
	✅
	7
	§6可定位三件套
	grep "Flag Registry"
	可定位
	✅
	8
	required_event_logs路由到SRS
	定位§6.4
	可定位
	✅
	9
	flag_change_requested/applied可定位
	grep事件名
	可定位
	✅
	10
	freeze_state Fail-Closed可定位
	定位§8.1
	可定位
	✅
	11
	降級決策樹可定位
	grep "ARCH-DEGRADE"
	可定位
	✅
	12
	APPX-B REQ21有acceptance_ptr
	定位APPX-B
	21列有值
	✅
	13
	RS-B覆蓋統計可定位
	定位APPX-C
	可定位
	✅
	14
	ICRU能力鏈可定位
	定位§5.3.2
	可定位
	✅
	15
	Fitness門檻→Route-Out
	定位§7
	有Route-Out
	✅
	16
	三角角色無審批gate
	定位§4.14.1.1
	無新增
	✅
	17
	Anchor Registry存在
	定位§0.5
	可定位
	✅
	18
	回歸檢查不通過→CR-OPEN
	本表存在
	可定位
	✅
	19
	grep "must/必須/shall"新增處需有authority_source
	需有authority_source
	✅
	

	20
	任一互斥/缺授權/缺映射→CL/CAND/CR-OPEN
	Fail-Closed
	✅
	

	回歸檢查執行政策：
* 未通過任一條視為架構漂移，需登記CR-OPEN
* 升版前必須全部PASS
________________


APPX-D Schema Examples（架構層最小範例）
[ANCHOR:ARCH-APPX-D-SCHEMA]
本附錄提供架構層最小欄位範例（非完整Schema）。完整Schema見ICD。
D.1 sf_stage_id範例
{
  "sf_id": "SF-05",
  "stage_name": "Method Card Generation",
  "status": "COMPLETED",
  "timestamp": "2026-01-08T10:30:00Z"
}


D.2 event_log範例
{
  "event_id": "EVT-20260108-001",
  "event_type": "flag_change_applied",
  "payload": {"flag_id": "allow_xsat", "old_value": false, "new_value": true},
  "timestamp": "2026-01-08T10:30:00Z"
}


D.3 flag_registry範例
{
  "flag_id": "allow_xsat",
  "value": false,
  "authorization_status": "SRS_AUTHORIZED",
  "last_modified": "2026-01-08T10:00:00Z"
}


D.4 run_config_snapshot範例
{
  "config_version": "v6.0.0",
  "run_id": "R-20260108-103000-0001",
  "trading_mode": "T0_DAYTRADE",
  "execution_mode": "NON_AGENT",
  "flag_values": {"allow_xsat": false}
}


D.5 degrade_matrix範例
{
  "rule_id": "DG-AUTO-01",
  "trigger_condition": "LLM API連續3次失敗",
  "current_status": "INACTIVE",
  "last_triggered": null
}


Route-Out：完整Schema見ICD [SCHEMA-*]
APPX-E P0 Daily Task Architecture Mapping
[ANCHOR:ARCH-P0-TASK-MAPPING] [NEW:PATCH-063]
P0-Q&A定義的日常任務(a-m)與架構的系統映射。
任務
	說明
	主要子系統
	架構支撐點
	a
	教材蒐集與驗證
	CA-WRC, CA-CORPUS
	§4.1, §4.2
	b
	蒸餾與技術提取
	CA-DISTILL
	§4.3
	c
	方法卡生成
	CA-METHOD
	§4.5
	d
	歷史資料準備
	CA-CORPUS
	§4.2.6 [ANCHOR:ARCH-HISTORICAL-DATA]
	e
	回測執行
	CA-BACKTEST
	§4.7
	f
	策略篩選
	CA-TA
	§4.8
	g
	訊號生成
	CA-WATCH
	§4.10
	h
	XQ全球贏家整合
	CA-TRANSLATE
	§4.9
	i
	訂單執行
	CA-EXECUTE
	§4.11
	j
	績效追蹤
	CA-PERFORM
	§4.15
	k
	風控監控
	CA-GOVERN
	§4.13
	l
	報告生成
	CA-UI
	§4.12
	m
	系統維護
	CA-COLLAB
	§4.14
	Route-Out：任務詳細流程見Runbook [RUNBOOK-DAILY-TASKS]
________________


Anti-Drift檢核清單
[ANCHOR:ARCH-ANTI-DRIFT-CHECKLIST]
檢核項
	檢核方法
	預期結果
	狀態
	CA-FIREWALL不殘留
	grep "CA-FIREWALL"
	僅出現在變更記錄/刪除說明
	✅ PASS
	CA-AGENT已整併
	檢查§4.17
	為Arbiter非子系統
	✅ PASS
	SF-11非子系統
	檢查§5.4描述
	明確為Gate，不含"子系統"字樣
	✅ PASS
	子系統數量=15
	計數§4子系統
	等於15（CA-WRC至CA-GOVERN）
	✅ PASS
	無量化門檻
	grep "≤|≥|%|ms" 正文
	僅出現在Route-Out說明
	✅ PASS
	Candidate無門檻
	檢查§0.2
	僅描述責任路由
	✅ PASS
	Route-Out可定位
	檢查§10所有錨點
	目標文件存在或標記CR_OPEN
	✅ PASS
	SEM³三Gate完整
	檢查§6.8
	SGF/MSC/TVE均有完整定義
	✅ PASS
	Gate分層架構完整
	檢查§6.0
	Policy/Check分離，三態gate_policy
	✅ PASS
	旗標分層對齊SRS
	檢查§6.1.1
	Tier-0≤3，對齊SRS v7.0.0-patch2
	✅ PASS
	Flag Usage Matrix存在
	檢查§6.1.2
	15子系統旗標使用對照
	✅ PASS
	XDOC-FLAG-CONSISTENCY
	檢查§6.1.3
	跨文件一致性Gate定義
	✅ PASS
	5關鍵構件存在
	檢查§3.2
	Orchestrator/Artifact Store/Validators/Evals Runner/Automation Assistant
	✅ PASS
	H3-H7假說架構落地
	檢查對應章節
	5個假說均有架構支撐點
	✅ PASS
	Candidate Fence通過
	執行FENCE Lint
	無違規項
	✅ PASS
	Six Core Objectives
	檢查§7.5
	G1-G6全部有架構支撐
	✅ PASS
	Agent雙模8條完整
	檢查§4.14
	SRS-AGENT-001~008全覆蓋
	✅ PASS
	控制面三件套完整
	檢查§6.5-6.7
	intent_spec/validation_hook/evidence_refs
	✅ PASS
	MarketProfile SSOT
	檢查§4.5.2
	MarketProfile架構存在
	✅ PASS
	三軸約束完整
	檢查§8.4+§8.7
	軸一/軸二/軸三均有架構
	✅ PASS
	JobCard架構完整
	檢查§5.6
	9欄位+生命週期+Rollback定義完整
	✅ PASS
	WebTools-NA獨立章節
	檢查§4.19
	對齊SRS §3.19
	✅ PASS
	三軸約束統一架構
	檢查§8.7
	軸一/軸二/軸三+協調器定義完整
	✅ PASS
	________________


[END OF DOCUMENT]
________________


文件終結聲明：
本《Spartoi｜P1_ARCH_v6.0.0-patch-r3》已完成以下工作：
r2工作項（維持）：
1. ✅ 整合審查修補方案v2.0.0全部65項Patch
2. ✅ 整合ΣHybrid SEM³ Blueprint完整定義（三Gate架構、責任矩陣、RACI、事件介面）
3. ✅ 補齊5大關鍵構件（Orchestrator/Artifact Store/Validators/Evals Runner/Automation Assistant）
4. ✅ 補回ICT熱插拔架構（含雙鍵綁定）
5. ✅ 補回時間窗不變量表
6. ✅ 補回ICRU能力鏈（Evidence Chain Table）
7. ✅ 補回五大核心目標架構支撐（已升級為Six Core Objectives）
8. ✅ 補回H5 Attended-first架構策略
9. ✅ 補回H6 Fitness雙跑道架構
10. ✅ 補回H7 Arbiter仲裁架構
11. ✅ 補回P1最小閉環7項架構對齊
12. ✅ 補回P0日常任務架構映射
13. ✅ 補回Candidate Fence檢查機制
14. ✅ 不可回退項維護完成（CA-FIREWALL刪除、SF-11為Gate、Candidate治理語義）
r3新增工作項（SRS審查報告回應）： 15. ✅ CA-AGENT整併至CA-COLLAB，維持15子系統架構 16. ✅ 升級為Six Core Objectives（G1-G6）完整架構支撐 17. ✅ 補齊Agent雙模8條需求架構（SRS-AGENT-001~008） 18. ✅ 補齊控制面三件套架構（intent_spec/validation_hook/evidence_refs） 19. ✅ 補齊MarketProfile SSOT與SessionPolicy架構 20. ✅ 補齊CA-UI決策隔離/JobCard/Capability架構 21. ✅ 補齊台股微結構三軸約束架構 22. ✅ 補齊Decision Package與Dual-Write機制 23. ✅ 補齊降級矩陣DG-AUTO-03 24. ✅ 補齊Canonical Corpus Manifest/Provenance架構 25. ✅ 補齊Track-A五可量測目標架構 26. ✅ 補齊run_config_snapshot 10欄位對齊 27. ✅ 補齊ICT台股在地化映射架構 28. ✅ Anti-Drift檢核全部PASS（16項）
Supersedes: Spartoi_P1_ARCH_v6.0.0-patch-r2及所有更早版本
Supersedes: Spartoi_P1_ARCH_v6.0.0初版及所有更早版本