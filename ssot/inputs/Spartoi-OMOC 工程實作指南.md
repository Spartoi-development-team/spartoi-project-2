# **Spartoi-OMOC 工程實作指南**

---

## **目錄（TOC)**

## **1\. 核心戰略與架構定義 (Strategy & Architecture)**

本章確立以「方案 B」為核心，融合 OMOC 執行能力與 Spartoi 治理規範的最高指導原則。

### **1.1 核心價值與方案定義**

* **1.1.1 方案 B：單一流水線與參數化**  
  * **定義**：採用 GitHub Matrix、CA\_ID 參數化與 Reusable Workflows，拒絕自研 Pipeline DSL \[Spartoi-OMOC\_開發實作方案.md\]\[OMOC-GMA Lite 實作指南.md\]。  
  * **目標**：最短工期、最低人工、最大化利用現成輪子 \[Spartoi-OMOC\_開發實作方案.md\]。  
* **1.1.2 雙平面架構 (Dual Plane Model)**  
  * **執行平面 (Execution Plane)**：以 OMOC (OpenCode) 作為 Agent Harness，負責「執行、產出、自動修復」 \[OMOC-GMA Lite 實作指南.md\]\[Spartoi-OMOC\_開發實作方案.md\]。  
  * **控制平面 (Control Plane)**：以 GitHub 原生治理 (Rulesets, Merge Queue) 負責「阻斷、裁決、證據」，實作 Spartoi CA-GOVERN 職責 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **1.1.3 完整版定義 (Definition of Done)**  
  * **合法定義**：控制面工程化 \+ 全 CA 工作站可跑 \+ 驗收閉環 PASS \+ EXECUTE 鎖定 (HITL/Kill-Switch) \[Spartoi-OMOC\_開發實作方案.md\]。  
  * **非法定義**：禁止「自動下單」與「無人值守資金操作」 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

### **1.2 權威堆疊與 SSOT (Authority Stack)**

* **1.2.1 權威順位**：P0-Q\&A \> REQ21 \> SRS \> ARCH \> ... \> OMOC Generic Guide \[Spartoi-OMOC 工程實作指南-目錄\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **1.2.2 雙憲法降級**：Runbook 為 Implementation SSOT，規劃層權威歸屬於藍圖 SSOT \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **1.2.3 規則引用原則**：One-rule-one-place，規則僅存在藍圖或 Runbook 其一 \[Spartoi-OMOC 工程實作指南-目錄\]。

### **1.3 關鍵約束與紅線 (Constraints)**

* **1.3.1 XQ 唯一下單端**：本地/雲端僅產指令，實際下單僅在 XQ \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **1.3.2 No-Paid-LLM-API**：核心功能不依賴付費 API，主路徑為 No-API \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **1.3.3 HITL 強制介入**：涉及資金操作必須人工確認，禁止無人值守 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **1.3.4 Fail-Closed**：遇不確定、缺口或驗證失敗，預設阻斷 \[Spartoi-OMOC\_開發實作方案.md\]\[OMOC-GMA Lite 實作指南.md\]。

## **2\. 控制平面實作 (Control Plane Implementation)**

本章定義如何利用 GitHub 原生機制實作 Spartoi 的 CA-GOVERN 職責。

### **2.1 基礎設施與環境**

* **2.1.1 GitHub Rulesets**：Repo-level 強制，禁止繞過，鎖定 main 分支 \[OMOC-GMA Lite 實作指南.md\]。  
* **2.1.2 Merge Queue**：強制序列化合流，避免競態條件 \[OMOC-GMA Lite 實作指南.md\]\[Managing a merge queue \- GitHub Docs\]。  
* **2.1.3 Artifact Attestations**：使用 `attest-build-provenance` 產生不可篡改來源證明 \[OMOC-GMA Lite 實作指南.md\]\[Provenance attestations \- Docker Docs\]。

### **2.2 控制面三件套 (The Trio)**

* **2.2.1 Flag Registry (旗標)**：Tier-0/1/2 分層，定義 allow\_xsat 等高風險開關 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **2.2.2 Degrade Matrix (降級)**：定義 DG-AUTO 等降級規則與 Fail-Closed 行為 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **2.2.3 Run Config Snapshot**：每次執行必產出的配置快照，含 agent/mode 狀態 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。

### **2.3 Gate 體系 (GateKit)**

* **2.3.1 Gate 分層架構**：Policy (裁決層) 與 Check (檢核層) 分離 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
* **2.3.2 8 Gate 模板**：G-SRC, G-SCHEMA, G-BT-H, G-SEG-L, G-CONF-L, G-XQ-PARITY, G-HITL-LOG, G-RUN \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **2.3.3 GateRunner**：最薄執行器，讀 manifest → 執行檢核 → 產三件套 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

## **3\. 執行平面：OMOC 引擎配置 (Execution Plane)**

本章定義如何配置 OpenCode 與 OMOC 以支援 Spartoi 的 15 CA 工作站。

### **3.1 環境與運行時**

* **3.1.1 OpenCode CLI**：安裝與初始化，Node.js 18+ 環境 \[CLI | OpenCode\]\[OMOC-GMA Lite 實作指南.md\]。  
* **3.1.2 配置文件 (opencode.json)**：定義 Agent 行為、權限 (Permission) 與模型 \[Config | OpenCode\]\[整合平面工具鏈與量化交易邏輯之自動化骨架...\]。  
* **3.1.3 Codespaces 固化**：`.devcontainer` 鎖定工具鏈版本，確保可重現性 \[OMOC-GMA Lite 實作指南.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

### **3.2 Agent 4 線模組化 (4-Lanes)**

* **3.2.1 配置結構**：`.opencode/agents/` 下定義 vibe, spec, dev, ops 模式 \[OMOC-GMA Lite 實作指南.md\]。  
* **3.2.2 Spec Mode (規範)**：掛載 DocOps Skills，產出 SSOT，溫度 0.0 \[OMOC-GMA Lite 實作指南.md\]。  
* **3.2.3 Dev Mode (實作)**：TDD 循環，掛載 MegaLinter 與 Test Skills \[OMOC-GMA Lite 實作指南.md\]。  
* **3.2.4 Ops Mode (運維)**：高權限，掛載 Release Skills，預設禁用 Cowork \[OMOC-GMA Lite 實作指南.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

### **3.3 技能生態 (Skill Ecosystem)**

* **3.3.1 Skilz-CLI**：技能套件管理，`registry.yaml` 白名單鎖定 SHA \[OMOC-GMA Lite 實作指南.md\]\[opencode-ai/opencode...\]。  
* **3.3.2 Spartoi MVS (最小技能集)**：`spartoi-schema` (定案), `evidencepack-builder` (CR\_OPEN) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **3.3.3 Input Trust Tier**：L0-L3 信任分級，L3 (Untrusted) 拒收或 Sanitizer \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

## **4\. 領域實作：15 CA 工作站 (15 CA Stations)**

本章將 Spartoi 的 15 個子系統映射為 OMOC 的標準化工作站。

### **4.1 工作站標準結構**

* **4.1.1 目錄規範**：每個 CA 獨立目錄，含 `task_manifest.yaml`, `adapters/` \[Spartoi-OMOC 工程實作指南-目錄\]\[Spartoi-OMOC\_開發實作方案.md\]。  
* **4.1.2 I/O 契約**：`inputs_manifest` → Process → `evidence_manifest` \+ `verdict` \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。

### **4.2 知識管線 (Pipeline A: SpecPack)**

* **4.2.1 CA-WRC (教材蒐集)**：白名單匯入，產出 `input_manifest` \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **4.2.2 CA-CORPUS (語料庫)**：建立索引，產出 `corpus_snapshot` \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **4.2.3 CA-DISTILL (蒸餾)**：三層蒸餾 (SEM³)，產出 `distill_bundle`，通過 G-SEG-L \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **4.2.4 CA-DSL (原語庫)**：產出 `dsl_schema`，MarketProfile SSOT \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。

### **4.3 策略管線 (Pipeline B: StrategyPack)**

* **4.3.1 CA-METHOD (方法制定)**：產出 `method_card`，三源融合 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **4.3.2 CA-BACKTEST (回測)**：雙引擎驗證，產出 `backtest_summary`，通過 G-BT-H \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。

### **4.4 執行管線 (Pipeline C: XSPack)**

* **4.4.1 CA-TA (技術分析)**：產出 `ta_pack` \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
* **4.4.2 CA-SELECT (選股)**：產出 `select_results` \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **4.4.3 CA-TRANSLATE (轉譯)**：產出 `xs_pack`，通過 G-XQ-PARITY (TVE) \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

### **4.5 運行與治理 (Runtime & Governance)**

* **4.5.1 CA-WATCH (盯盤)**：產生 `watch_plan`，不下單 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **4.5.2 CA-EXECUTE (操盤)**：產生 `hitl_handoff`，唯一下單端指令 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **4.5.3 CA-PERFORM (績效)**：產出 `perf_summary`，雙跑道分析 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **4.5.4 CA-GOVERN (治理)**：控制面主控，Gate 執行 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **4.5.5 CA-UI (入口)**：單一操作入口，WebTools-NA \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **4.5.6 CA-COLLAB (協作)**：多 AI 協作，Agent 雙模管理 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。

## **5\. 自動化流水線與任務編排 (Pipeline & Orchestration)**

本章定義如何將上述工作站串聯為自動化流水線。

### **5.1 核心流程 (SF Keyspace)**

* **5.1.1 SF 主鍵體系**：SF-00 \~ SF-31 唯一流程主鍵 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **5.1.2 JobCard 架構**：9 欄位標準 (Inputs/Commands/Acceptance/Rollback) \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。

### **5.2 三管線協作 (Pipeline A/B/C)**

* **5.2.1 Pipeline A (SpecPack)**：WRC → CORPUS → DISTILL → DSL \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **5.2.2 Pipeline B (StrategyPack)**：METHOD → BACKTEST \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **5.2.3 Pipeline C (XSPack)**：TA → SELECT → TRANSLATE \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

### **5.3 自動化執行**

* **5.3.1 Orchestrator**：單一流水線入口 `orchestrate` CLI \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **5.3.2 參數化執行**：Matrix 執行 15 CA，`reusable workflows` \[Spartoi-OMOC\_開發實作方案.md\]。  
* **5.3.3 文檔 Delta 回填**：流水線自動產出 SSOT 變更建議 \[Spartoi-OMOC\_開發實作方案.md\]。

## **6\. 交易領域邏輯與時序 (Trading Domain & Timeline)**

本章定義 Spartoi 特有的台股交易規則與不變量。

### **6.1 時序硬規則 (Invariants)**

* **6.1.1 INV-TIME-001**：13:10 禁新倉 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **6.1.2 INV-TIME-002**：13:20 強制清倉 (T0) \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **6.1.3 INV-TIME-003**：13:25-13:30 ROD-Only \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

### **6.2 雙模運行 (T0/T1)**

* **6.2.1 T0 當沖**：當日進出，強制平倉 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **6.2.2 T1 隔日沖**：只做多，需隔夜風控 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **6.2.3 產物隔離**：T0/T1 產物目錄分離 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

### **6.3 ICT 模組與熱插拔**

* **6.3.1 雙鍵綁定**：Slot Key (\#1-\#107) ↔ MethodCard Key \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **6.3.2 四路徑熱插拔**：DISABLED, REPLACED, ROLLBACK, A-B TEST \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **6.3.3 模組索引**：ICT 1\~107 完整映射 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

## **7\. 證據鏈與驗收 (Evidence & Acceptance)**

本章定義如何證明任務「做對了」。

### **7.1 Evidence Pack**

* **7.1.1 三件套**：`manifest.json`, `gate_report.json`, `artifacts/` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **7.1.2 Verdict 機制**：Layer-1 機械裁決，禁止 LLM 自行生成 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **7.1.3 回放契約**：L1/L2/L3 可回放標準 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

### **7.2 驗收體系**

* **7.2.1 MAI (Master Acceptance Index)**：需求對應驗收鉤子 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **7.2.2 RTM (Traceability Matrix)**：需求追溯矩陣 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **7.2.3 Fitness Functions**：13 條核心品質量測 (Fit-001\~013) \[Spartoi｜P1\_LBP-E(Fitness)\_v3.0.1.md\]。

## **8\. 運維與故障處置 (Operations & Failure Handling)**

本章定義系統運維的 SOP 與異常處理。

### **8.1 日常作業**

* **8.1.1 P0 任務映射**：日常任務 a-m 操作流程 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **8.1.2 每日抽驗**：Crosswalk 與 Gate 抽驗 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

### **8.2 風險防線**

* **8.2.1 Kill Switch**：KS-001\~007 觸發條件與行為 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **8.2.2 Rollback**：RB-001\~006 回滾策略 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **8.2.3 CR\_OPEN 管理**：Candidate 遷移與關單流程 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。

## **9\. 附錄與索引 (Appendices)**

* **APPX-A. Crosswalk (Legacy)**：舊 Token 對照 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **APPX-B. Conflict Ledger**：衝突裁決記錄 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **APPX-C. CR\_OPEN Register**：待決事項清單 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **APPX-D. Gate Templates**：8 Gate 詳細規格 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **APPX-E. Web Evidence Index**：外部證據索引 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **APPX-F. Route-Out Register**：跨文件路由表 \[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。

---

# 1\. 核心戰略與架構定義 (Strategy & Architecture)

本章確立「Spartoi-OMOC 工程實作指南」的最高指導原則。依據《Spartoi-OMOC\_開發實作方案.md》，本指南不追求發明新框架，而是以 **「方案 B」** 為核心，將 **OMOC (Oh My OpenCode)** 的高效執行能力與 **Spartoi** 既有的嚴格治理規範（15 CA、ICT、台股規則）進行「混血融合」。目標是在 **最短開發時間** 內，達成 **「最少人工、只看 PASS」** 的工程境界。  
---

## **1.1 核心價值與方案定義** ---

#### **1.1.1 方案 B：單一流水線與參數化 (Plan B: Single Pipeline & Parameterization)**

本架構採用「方案 B」作為落地的唯一路徑，拒絕自研 Pipeline DSL 或複雜的平台化調度器。其核心在於利用現成的 GitHub Actions 機制，將重複的機械步驟消除。

* **單一流水線架構**：

  * **矩陣執行 (Matrix Strategy)**：建立單一 `pipeline.yml`，透過 GitHub Actions 的 `matrix` 策略，一次性調度 **15 個 CA 子系統**（如 CA-WRC, CA-CORPUS... CA-GOVERN）。  
  * **參數化驅動 (CA\_ID Parameterization)**：流水線不寫死邏輯，而是讀取參數（如 `CA_ID`）。每個 Job 僅執行標準三步驟：(1) 讀取 `ca/<CA_ID>/station.config`，(2) 執行可重用工作流，(3) 上傳證據包（Evidence Pack）。  
  * **去重複化**：利用 **Reusable Workflows (`workflow_call`)** 封裝通用的「檢核、環境建置、回報」邏輯；利用 **Composite Actions** 封裝重複的 CLI 指令。  
* **最短工期與最低人工**：

  * 此方案直接利用 GitHub 原生能力（Inputs/Secrets/Outputs），避免了自研「任務分派引擎」或「工作流平台」的開發成本，是達成「不造輪子」的關鍵槓桿。  
  * 目標是讓開發者只需維護每個 CA 的設定檔與 Adapter，而非維護一套基礎設施。

#### **1.1.2 雙平面架構模型 (Dual Plane Model)**

為了在「AI 執行的高效能」與「金融交易的零容錯」之間取得平衡，本架構嚴格執行 **「控制平面 (Control Plane)」** 與 **「執行平面 (Execution Plane)」** 的物理分離原則。

* **執行平面 (Execution Plane)：OMOC 作為 Agent Harness**

  * **定位**：這裡是系統的「油門」與「工廠」。OMOC (OpenCode) 擔任 **Agent Harness (代理掛具)**，負責「把事做完」與「自動修復」。  
  * **運行環境**：必須在 **GitHub Codespaces** 或受控的容器環境中運行，透過 `.devcontainer` 鎖定工具鏈（Node.js 18+, Python, CLI），確保「可重現性」。  
  * **角色分工**：  
    * **Sisyphus (主控)**：負責寫操作的串行執行（One Brain, One Stream）。  
    * **Atlas (監工/自癒)**：負責監控執行並觸發 `ci-fix` 自動修復。  
    * **Prometheus (戰略)**：負責 Plan Mode 的需求訪談與架構拆解。  
  * **限制**：執行平面的產出僅視為「候選（Candidate）」，不具備最終生效的法律效力，必須經過控制平面驗收。  
* **控制平面 (Control Plane)：GitHub 原生治理**

  * **定位**：這裡是系統的「煞車」與「最高法院」。負責「阻斷（Blocking）」、「裁決（Verdict）」與「證據留存（Evidence）」。  
  * **職責實作**：  
    * **CA-GOVERN**：作為控制面的邏輯核心，管理旗標（Flag）、降級矩陣（Degrade Matrix）與配置快照（Snapshot）。  
    * **GitHub Rulesets**：負責 Repo 層級的 Fail-Closed 阻斷，物理鎖死 Merge 按鈕。  
    * **Merge Queue**：強制序列化合流，消除多代理協作的競態條件。  
    * **Artifact Attestations**：產生不可篡改的來源證明（Provenance），確保供應鏈安全。  
  * **紅線**：控制平面禁止運行任何「互動式認證」的 LLM，必須依賴確定性的機械規則或已簽章的證據。

#### **1.1.3 完整版定義 (Definition of Done)**

針對「直接做完整版」的開發目標，本指南依據 SSOT（單一真相來源）確立了嚴格的驗收口徑，防止因定義模糊導致的「造輪子」或「違規」。

* **合法定義（✅ 可宣稱完成）**：

  * **控制面工程化 (P2)**：控制面三件套（Flag, Degrade, Snapshot）已落地並由 CI 強制執行。  
  * **全 CA 工作站可跑**：15 個 CA 子系統皆能透過流水線執行，並產出符合契約的 Manifest/Verdict/Evidence。  
  * **驗收閉環 PASS**：所有 Required Checks、GateKit 與 E2E Smoke Test 皆通過。  
  * **EXECUTE 鎖定**：高風險的 `CA-EXECUTE` 路徑預設為 `HITL`（人機介入）或 `EXECUTE_DISABLED`（禁用），且受 Kill-Switch 保護。  
* **非法定義（❌ 禁止宣稱）**：

  * **自動下單**：嚴禁將「完整版」定義為無人值守的自動下單系統。這違反了「XQ 唯一下單端」與「資金操作必須人工確認」的硬性紅線。  
  * **P1/P2 邊界混淆**：P1 階段僅負責產出「合約與證據鏈」，嚴禁在 P1 階段實作運行期的自動化交易代碼。

#### **1.1.4 關鍵約束與紅線 (Constraints)**

為確保架構不發生漂移（Drift），以下約束被定義為系統級的不變量（Invariants）：

* **XQ 唯一下單端**：本地/雲端系統僅能產生訊號或指令文件，實際下單動作僅能在 XQ 全球贏家桌面端進行。  
* **No-Paid-LLM-API**：核心功能主路徑必須不依賴付費 LLM API（如 GPT-4 API），以確保系統在無 API Key 狀態下的可持續性與低成本。  
* **HITL 強制介入**：涉及資金操作的節點（SF-11），必須有人類操作員（Human-in-the-Loop）明確簽核，禁止 AI 自主決策。  
* **Fail-Closed (預設阻斷)**：遇不確定、缺口（Missing）、驗證失敗（FAIL）或無來源依據的情況，系統行為必須預設為「阻斷（Block）」或「降級（Degrade）」，不得假設通過。  
* **反平台化條款**：禁止建立「大一統控制台（Unified Console）」或「複雜排程系統」，堅持「檔案即治理（File-based Governance）」與「Repo 即平台」。

---

## **1.2 權威堆疊與 SSOT (Authority Stack)**

本章節確立 Spartoi-OMOC 系統中所有規範文檔的「權威順位（Precedence）」與「單一真相來源（Single Source of Truth, SSOT）」原則。依據「Spartoi-OMOC 工程實作指南：目錄」與「Spartoi｜P1\_SRS v7.0.0」之定義，系統運作必須嚴格遵循此階層，以解決文件間的潛在衝突，並防止規範漂移（Spec Drift）。  
---

### **1.2.1 權威順位 (Authority Precedence)**

為了確保在需求、架構與實作發生衝突時有明確的裁決依據，系統強制執行以下八層權威堆疊。當下位文件與上位文件衝突時，**必須無條件服從上位文件**，並將衝突登錄於 Conflict Ledger。

| 順位 | 文件名稱 (ID) | 版本要求 | 核心職責與裁決效力 | 來源 |
| ----- | ----- | ----- | ----- | ----- |
| **1 (最高)** | **P0-Q\&A\_1114** | \- | **系統硬約束/作業鏈**。定義了「單人+多AI協作」、「雲地系統」與「日常任務 a-m」。此為最高權威，不可被任何下位文件覆蓋。 | ,,, |
| **2** | **Spartoi 系統 21 項需求 (REQ21)** | \- | **核心硬約束**。定義了「No-Paid-LLM-API」、「唯一下單端 XQ」等不可妥協條款。若與 P0 衝突以 P0 為準。 | ,, |
| **3** | **待補充需求庫 (RS-B)** | \- | **缺口補齊**。補足 P1 階段的 642 條細節需求。所有條目必須全量處置（Disposition），不得遺漏。 | ,, |
| **4** | **StRS+SyRS** | v5.2.0 | **上位需求**。提供系統層級（System Level）與軟體層級（Software Level）的原始需求對照。 | ,, |
| **5** | **凍結合冊 (Frozen Bundle)** | v1.1.0 | **證據參考**。僅作為 P0 階段的證據快照，權威次於 RS-B。 | ,, |
| **6** | **P1\_SRS (需求規格)** | v7.0.0 | **需求 SSOT**。這是 P1 階段裁決「功能/非功能需求」的最終權威。任何開發中的需求衝突，若未涉及 P0/REQ21，皆以此文件為準。 | ,,, |
| **7** | **P1\_ARCH (架構設計)** | v6.0.0-r5 | **架構 SSOT**。定義 15 子系統邊界、命名、介面與技術選型。 | ,, |
| **8 (最低)** | **Runbook / SFHB** | v1.4.0 / v2.1.0 | **程序規格 (Procedure Spec)**。僅定義「如何做（How）」，不得定義「要做什麼（What）」。若與 SRS/ARCH 衝突，**以 SRS/ARCH 為準**。 | ,, |

**裁決規則 (Fail-Closed Rules)：**

1. **高順位覆蓋低順位**：若 Runbook 寫「13:20 ROD-only」但 SRS 寫「13:25」，必須採用 SRS 之定義。  
2. **同順位取最新**：若同層級文件有版本差異，以版號較新者為準。  
3. **無法裁決即阻斷**：若依據上述規則仍無法判定，必須登記 `CR_OPEN` 並執行 `Fail-Closed`（預設阻斷發布），禁止擅自解讀。

---

### **1.2.2 雙憲法降級 (Dual Constitution Demotion)**

依據「Spartoi-OMOC\_開發實作方案」與「Runbook v1.4.0」的定義，為了避免「執行層」篡改「規劃層」的規則，系統實施「雙憲法降級」策略。

* **規劃憲法 (Planning Constitution) \- 上位 SSOT**

  * **代表文件**：藍圖 (Blueprint) v1.2.2、SRS v7.0.0。  
  * **職責**：定義 Authority Stack、Conflict Rule、Scope-Lock、Gate Policy (三態) 與 Stopline。  
  * **地位**：這是法律的制定者（Legislative）。Runbook 必須引用此處的定義，**不得自行重新定義**,。  
* **實作憲法 (Implementation Constitution) \- 下位 SSOT**

  * **代表文件**：Runbook v1.4.0、OMOC 實作指南。  
  * **職責**：將規劃層的規則轉化為 Step-by-step 的操作指令、定義每步的 I/O、驗證與證據落點。  
  * **地位**：這是法律的執行者（Executive）。它被明確定義為 **Implementation SSOT**，其權威性被「降級（Demotion）」，在規範衝突時無裁決權,,。

**降級實作範例：**

* Runbook 不得定義「Gate 有哪幾類」，只能引用藍圖的 `[BP-7-GATE-CLASSES]`。  
* Runbook 不得定義「Tripwires」，只能引用藍圖的 `[BP-TRIPWIRES]`。

---

### **1.2.3 規則引用原則 (One-Rule-One-Place)**

為了消除文件間的「雙重維護（Dual Maintenance）」與「內容漂移（Content Drift）」，Spartoi-OMOC 架構強制執行 **One-Rule-One-Place** 原則。

* **定義**：任何規則、門檻、清單或定義，只能在 **一份** SSOT 文件中以 Normative（規範性）形式存在。其他文件若需提及，**必須** 使用指標（Pointer/Reference）引用，禁止複製貼上正文,。

* **實作機制 \- Route-Out (外導)**：

  * 當 LBP-D(C4) 需要提及「需求條文」時，必須寫 `Route-Out: SRS v7.0.0 [SRS-V700-FR-XXX]`，禁止重寫需求文字。  
  * 當 ADR 需要提及「介面細節」時，必須寫 `Route-Out: LBP-B(ICD) [SCHEMA-XXX]`，禁止重寫 Schema。  
  * 當 Runbook 需要提及「操作風險」時，必須引用藍圖的 `[BP-RISK-DEFENSE]`。  
* **禁止雙寫 (No-Dual-Write)**：

  * 嚴禁在 ADR、Runbook 或 README 中「雙寫」SRS 的需求條文。  
  * 嚴禁在 SRS 中「雙寫」ARCH 的架構設計細節。  
  * 違規者將在 Gate 檢查（如 `G-SRC` 來源完整性 Gate）中被標記為 **BLOCK\_RELEASE**,。  
* **Evidence ≠ Norm (證據不等於規範)**：

  * 引用外部資料（如 ICT 教材、Web Evidence）僅能作為「證據（Evidence）」支撐決策，**不得直接升格為規範（Norm）**。若需轉為規範，必須經過 CR\_OPEN 流程並在 SSOT 中正式定義,。

---

## 1.3 關鍵約束與紅線 (Constraints)

本章節確立 Spartoi-OMOC 系統工程實作中的不可協商條款（Non-negotiables）。這些約束不僅是開發規範，更是系統的「憲法」，任何違反此四項紅線的設計或代碼，無論其功能多強大，皆視為「不合規」並應觸發 BLOCK\_RELEASE \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1[.4.0.md](http://.4.0.md)\]。  
---

#### **1.3.1 XQ 唯一下單端 (XQ Sole Order Endpoint)**

**核心定義**：本地系統（Spartoi-OMOC）與雲端環境僅負責產生訊號、指令文件與證據；實際下單、成交與資金操作**必須且只能**在「XQ 全球贏家（XQ Global Winner）」桌面端軟體完成 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

* **物理隔離原則**：

  * **本地職責**：CA-WATCH 負責產生入場提醒與 WatchScore；CA-EXECUTE 負責產生委託指令（Order Instructions）與 HITL 交接包（hitl\_handoff.json）。本地代碼**嚴禁**直接呼叫券商 API 進行下單 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
  * **執行端職責**：XQ 桌面端是唯一的執行介面。若需自動化，僅允許使用 XQ 內建的 XSAT（XS Auto Trading）模組，且該模組能力邊界需經 CR\_OPEN-007 驗證 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **防誤解宣告**：

  * 任何文檔或代碼中出現的「自動下單」、「執行交易」字樣，在 Spartoi P1 階段的語義**僅限於**「產生可執行的指令文件」，絕非「程式自動送出委託單」 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi-OMOC\_開發實作方案.md\]。  
  * 所有涉及資金的操作（進場、加碼、減碼、平倉）必須經過 SF-11 HITL Gate 的人工確認 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **ADR 決策支撐**：

  * 依據 **ADR-037**，確立 XQ 為唯一下單端，本地系統僅產生委託指令 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
  * 依據 **ADR-024**，Kill Switch 的實作在本地僅為「發出緊急平倉指令」與「停止策略邏輯」，實際平倉動作需人工在 XQ 端執行或確認 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。

#### **1.3.2 No-Paid-LLM-API (No Paid Cloud LLM API)**

**核心定義**：Spartoi P1 的核心功能流程（Core Flow）**不得依賴**付費的雲端 LLM API（如 GPT-4 API, Claude API Paid Tier）作為必要路徑。系統必須能在「零額外 API 成本」的前提下完成最小閉環 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

* **No-Required-Cloud-LLM-API 政策**：

  * **主路徑（Main Path）**：必須是 No-API 模式（Non-API Mode）。這包括使用 Web 介面手動協作（WT-NA）、本地模型（Local LLM）、或免費層級 API（需白名單） \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **API 例外條款**：付費 API 僅可作為「可選加速（Optional Acceleration）」或「輔助決策」，不得成為系統運行的硬性依賴（Hard Dependency）。若系統離開 API Key 即無法運作，視為違規 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **白名單與信任分級**：

  * **免費 API 白名單**：允許使用經審核的免費 API（如 Claude Free Tier, GPT-4o-mini Free Tier），但必須登記於 `llm_whitelist.json` 並接受配額風險監控 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
  * **WebTools-NA (WT-NA)**：作為 No-API 的標準實作模式，採用「人工複製貼上協作」架構，並透過 `wtna_action_log.jsonl` 記錄操作軌跡以確保可稽核性 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **ADR 決策支撐**：

  * 依據 **ADR-029**，確立 No-Paid-LLM-API 政策，核心流程必須有本地回退路徑（Fallback Path） \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。

#### **1.3.3 HITL 強制介入 (Human-In-The-Loop Mandatory Intervention)**

**核心定義**：所有涉及「資金風險」與「狀態變更」的關鍵節點，**必須**經過人類操作員的明確確認（Explicit Confirmation）。系統不得在無人值守（Unattended）的情況下自動執行高風險操作 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。

* **SF-11 HITL Gate**：

  * **定位**：SF-11 不是一個子系統，而是流程中的「強制決策閘門（Gate）」。它位於 CA-WATCH（監控）與 CA-EXECUTE（執行）之間 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
  * **行為**：當系統產生交易訊號時，必須暫停並生成 `hitl_handoff.json`（交接包），等待人類在 CA-UI 介面或透過 Solo-Mode 機制簽核（APPROVE/REJECT）後，才允許進入下一步 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **決策包與證據鏈**：

  * **Decision Package**：每個 HITL 決策點必須生成完整的決策包，包含 `decision_id`、`options`、`recommended_default`、`override_reason` 與 `evidence_refs` \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **Solo-Mode 優化**：針對單人操作場景，提供簡化的 `single-file-ack` 機制，但不降低「必須有人確認」的邏輯要求 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **停止線（Stopline）**：

  * 若無 HITL 確認紀錄（`hitl_confirmed` 為 false 或缺失），CA-EXECUTE 必須拒絕產生執行指令，系統強制進入 **EXECUTE\_DISABLED** 狀態 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

#### **1.3.4 Fail-Closed (預設阻斷)**

**核心定義**：在任何不確定、資料缺失、驗證失敗或規則衝突的情況下，系統必須預設採取「阻斷（Block）」或「安全降級（Safe Degrade）」的行為，絕不允許「假設通過（Pass by Assumption）」 \[Spartoi-OMOC\_開發實作方案.md\]\[OMOC-GMA Lite 實作指南.md\]。

* **Gate Policy 三態體系**：

  * **BLOCK\_RELEASE**：阻斷發布與下游流程。適用於：來源完整性失敗（G-SRC）、Schema 驗證失敗（G-SCHEMA）、安全規則違反 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
  * **RADAR\_ONLY**：允許流程繼續但標記高風險，產出物不可用於自動決策。適用於：非關鍵品質指標未達標（如文件覆蓋率略低）、實驗性功能 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **EXECUTE\_DISABLED**：系統可運行但禁止任何交易執行相關動作。適用於：Kill Switch 觸發、HITL 未確認、關鍵資料源中斷 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **CR\_OPEN 治理**：

  * 所有未經 SRS 正式授權的規範（如 Candidate 門檻數值），必須登記為 **CR\_OPEN**，並預設綁定 **BLOCK\_RELEASE** 或 **RADAR\_ONLY** 策略，嚴禁在 Normative 區塊中直接寫死數值 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-E(Fitness)\_v3.0.1.md\]。  
  * **Evidence\_Refs 強制**：每條 CR\_OPEN 必須附帶至少 2 筆證據（Evidence\_Refs），否則視為無效需求，直接阻斷 \[Spartoi｜P1\_LBP-E(Fitness)\_v3.0.1.md\]。  
* **實作層落地**：

  * 在 OMOC-GMA Lite 架構中，Fail-Closed 被轉化為 GitHub Rulesets 的 **Required Status Checks**，物理鎖死 Merge 按鈕，確保無人工放行的可能性 \[OMOC-GMA Lite 實作指南.md\]\[Spartoi-OMOC\_開發實作方案.md\]。  
  * GateRunner 執行器在遇到未知錯誤（Unknown Error）時，必須返回非零退出碼（Exit Code ≠ 0），觸發 CI/CD 的失敗狀態 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

# ---

 **2\. 控制平面實作 (Control Plane Implementation)** ---

## **2.1 基礎設施與環境 (Infrastructure & Environment)**

本章節定義 Spartoi-OMOC 系統的**控制平面 (Control Plane)** 物理基礎。依據「方案 B」戰略，我們不自研治理平台，而是利用 GitHub 的原生機制（Rulesets, Merge Queue, Attestations）建立不可協商的「鐵閘門 (Iron Gates)」。此基礎設施的唯一目標是實現「Fail-Closed (預設阻斷)」，確保所有由執行平面（OMOC Agents）產出的工件，必須通過機械驗證才能進入主幹。  
---

### **2.1.1 GitHub Rulesets：立法與強制執行 (The Legislation)**

Rulesets（規則集）是本架構的立法機關，用於取代脆弱的傳統 Branch Protection Rules。它提供了跨 Repo 的策略統一與 Metadata 級別的限制，確保所有 CA 子系統（CA-WRC 至 CA-GOVERN）的變更都遵循同一套合流憲法。

#### **A. 核心配置與鎖定 (Target & Configuration)**

* **鎖定目標**：必須針對 Default Branch (通常為 `main`) 啟用 Ruleset。  
* **強制執行狀態**：`Enforcement Status` 必須設為 **Active**，嚴禁設為 Evaluate（僅觀察），以確保治理的物理強制力。  
* **Repo-level 強制**：相較於傳統分支保護，Rulesets 防止管理員意外刪除規則，並支援 Metadata 限制（如 Commit Message 格式）。

#### **B. 禁止繞過策略 (No Bypass Policy)**

* **Agent 限制**：嚴格禁止任何 Agent（如 Sisyphus, Claude Code 或 CI Bot）擁有 Bypass 權限。Agent 在系統中被視為「非受信實體」，必須像人類開發者一樣，通過所有檢查才能合流。  
* **Bypass List 清空**：在 Ruleset 設定中，Bypass list 必須為空，或僅限於 Organization admins 進行緊急修復 (Hotfix)。

#### **C. 核心規則清單 (Core Rules)**

依據 Spartoi 的安全需求，必須啟用以下規則：

1. **Restrict deletions**：啟用。防止主幹歷史被惡意或意外刪除。  
2. **Restrict force pushes**：啟用。防止歷史被重寫 (Rewrite History)，確保證據鏈的不可抵賴性。  
3. **Require a pull request**：啟用。禁止直接 Push 到主幹，強制所有變更走 PR 流程以觸發 CI Gate。  
4. **Require status checks to pass**：啟用。將 `docops-gatekit`、`security-scorecard` 等關鍵 Workflow 設為必過檢查。

### **2.1.2 Merge Queue：序列化合流與併發控制 (Serialized Merging)**

針對「方案 B」的自動化骨架，Merge Queue 是消除多 Agent 併發開發導致「競態條件 (Race Condition)」的唯一工程解法，確保主幹永遠處於可部署狀態（Always Green）。

#### **A. 核心機制：臨時合併分支**

* **運作邏輯**：當 PR 通過初步檢查並進入隊列後，GitHub 會自動創建一個臨時的合併分支（例如 `gh-readonly-queue/main/...`），將該 PR 與隊列中排在前面的所有變更進行預合併。  
* **序列化驗證**：系統會在此臨時分支上執行 Required Status Checks。只有當這些檢查全部通過（PASS）時，PR 才會被正式合併入 `main` 主幹。

#### **B. Workflow 觸發配置 (Fail-Closed Critical)**

這是本架構中最關鍵的技術細節之一。所有被標記為 \*\*Required Status Checks\*\* 的 Workflow YAML \*\*必須\*\* 包含 \`merge\_group\` 觸發條件，否則在進入隊列後檢查將不會執行，導致合流卡死或虛假通過 。

\`\`\`yaml  
name: CI Governance Gate  
on:  
  pull\_request:  
    branches: \[ "main" \]  
  merge\_group:    \# \<--- \[P0\] 必須存在！這是 Merge Queue 的觸發信號  
    types: \[checks\_requested\]

jobs:  
  gate-runner:  
    \# 確保在隊列中能正確讀取 Commit Context  
    runs-on: ubuntu-latest  
    steps:  
      \- uses: actions/checkout@v4

#### **C. 環境約束與降級 (Constraints & Fallback)**

* **方案限制**：Merge Queue 僅在 Public Repositories 或 GitHub Enterprise Cloud 的 Private Repositories 中可用。  
* **降級路徑 (Fallback)**：針對使用 GitHub Free/Team 方案的 Private Repositories，因無法使用 Merge Queue，必須回退至嚴格的 **Branch Protection Rules**，並啟用 "Require branches to be up to date before merging" 以模擬序列化驗證的效果，但需接受較高的人工更新成本。

### **2.1.3 Artifact Attestations：不可篡改的來源證明 (Provenance)**

為了滿足 Spartoi 對於「可稽核性 (Auditability)」與「供應鏈安全」的硬性要求（REQ21-06, REQ21-07），系統必須對所有產出工件（Evidence Pack, SpecPack, XSPack）進行數位簽章。

#### **A. 實作工具：`attest-build-provenance`**

* **工具選型**：採用 GitHub 官方 Action `actions/attest-build-provenance`。  
* **功能**：為構建產物生成符合 SLSA (Supply-chain Levels for Software Artifacts) 標準的來源證明（Provenance）。這證明了工件是在受控的 CI 環境中、由特定的 Workflow 運行、基於特定的 Git Commit 生成的，而非由 Agent 手動偽造。

#### **B. 驗證指令**

**驗收標準**：在 `handoff` 或 `release` 階段，系統必須支援使用 GitHub CLI 進行二次驗證：  
 gh attestation verify \<artifact-path\> \--owner \<org\>

*   
* **Fail-Closed**：若簽章無效、雜湊不符或來源不明，部署流程必須立即終止。

#### **C. 私有庫限制與對策**

* **限制**：官方 Artifact Attestations 目前對 Private Repositories 的支援有限制（通常需 Enterprise 方案）。  
* **替代方案 (Scheme B Lite)**：若無法使用官方 Attestation，必須實作「SHA256 自簽名流程」，將所有產物的 SHA256 Hash 寫入 `manifest.json`，並利用 GITHUB\_TOKEN 對 Manifest 進行簽署或存入受保護的 Artifact Store。

### **2.1.4 物理分離與 Fail-Closed 架構 (Physical Separation)**

依據 OMOC-GMA Lite 的核心哲學，系統嚴格執行「執行平面」與「控制平面」的物理隔離，以防止 AI Agent 的權限擴張。

#### **A. 雙平面定義**

| 平面 (Plane) | 載體 (Host) | 角色 | 權限邊界 | 來源 |
| ----- | ----- | ----- | ----- | ----- |
| **執行平面** | **Codespaces / Local** | **Agent Harness (OMOC)** | **選手**。負責執行、產出、修復。擁有 Write 權限，但無法直接寫入主幹。 |  |
| **控制平面** | **GitHub Actions** | **Governance Rulesets** | **裁判**。負責阻斷、裁決、證據存檔。擁有 Ruleset 鎖定權，Agent 無法觸碰。 |  |

#### **B. 物理鎖定 (Physical Lock)**

* **按鈕鎖死**：當任一 Required Check (MegaLinter, Tests, Build) 失敗或仍在進行中，GitHub 的 "Merge pull request" 按鈕必須呈現灰色不可點擊狀態 (Blocked)。  
* **零信任**：不接受 Agent 的口頭保證（如 "I have verified the code"）。只有控制平面產出的綠色勾號（PASS）才是唯一的放行依據。

#### **C. 輸入信任分級 (Input Trust Tier)**

為了防禦 Prompt Injection，基礎設施層必須支援輸入分級：

* **L3 (Untrusted)**：外部未淨化輸入（如網路爬蟲數據），在進入執行平面的一開始就必須被隔離或拒收。  
* **L0 (Trusted)**：來自 Evidence Pack 或已合併 PR 的內容，才允許 Agent 進行高權限操作。

---

**本章節全量整合來源索引：**

* *OMOC-GMA Lite 實作指南.md*:,,,,,,,,,,,,,  
* *Spartoi-OMOC\_開發實作方案.md*:,,,  
* *Spartoi-OMOC 工程實作指南：目錄（TOC）*:  
* *Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md*:  
* *Spartoi｜P1\_SRS\_v7.0.0.md*:  
* *整合平面工具鏈與量化交易邏輯之自動化骨架...*:,

---

## **2.2 控制面三件套 (The Trio)**

本章節詳述 Spartoi 系統中不可協商的「控制面三件套（The Trio）」。依據 ADR-026 與 SRS v7.0.0 定義，這三份文件構成了系統的**運行時憲法**。它們是「方案 B」單一流水線中，CA 工作站（Stations）執行邏輯的唯一參數來源，嚴禁任何子系統私自發明開關語意或繞過降級規則。  
---

### **2.2.1 Flag Registry (旗標)：分層與 SSOT 治理**

Flag Registry (`flag_registry.json`) 是系統中所有功能開關的**單一真相來源（SSOT）**。OMOC Agent 在執行時只能讀取此檔案，嚴禁寫入。寫入權限僅限於 CA-GOVERN 透過合規的 PR 流程變更。

#### **1\. 旗標分層架構 (Flag Tiering)**

為了防止旗標氾濫導致的組合爆炸與風險失控，系統強制執行三層分級制度。Tier-0 旗標數量受到硬性限制（≤3），以確保核心安全邊界清晰可控。

| 分層 (Tier) | 定義與權限 | 硬性限制 | 範例旗標 | 來源 |
| ----- | ----- | ----- | ----- | ----- |
| **Tier-0** | **系統級/授權級**。涉及資金安全、合約繞過或全系統行為改變。僅限 `OWNER` 經由 `G-GOV` 審核後變更。 | **數量 ≤ 3 個**默認值必須為 **Safe Default** (False/Block) | `allow_xsatrequire_full_reviewallow_bypass_contract` |  |
| **Tier-1** | **模式級/階段級**。控制特定流程分支（如 T1 隔日沖模式啟用）。需登記 CR\_OPEN。 | 無數量硬限，但需有退場機制 | `enable_t1_modeenable_agent_mode` |  |
| **Tier-2** | **標的級/交易域**。針對特定股票或市場狀態的微調（如處置股過濾）。 | 需綁定特定 `symbol` 或 `market_condition` | `symbol_suspendedliquidity_low` |  |

#### **2\. 核心旗標定義與安全預設 (Safe Default)**

依據「全域級必備原則」，所有高風險旗標必須具備「安全預設值」。當設定檔遺失或解析失敗時，系統必須回退至此安全狀態。

* **allow\_xsat** (Tier-0)  
  * **定義**：是否允許生成可執行自動交易的 XScript 代碼（XSAT）。  
  * **預設值**：`false` (BLOCK)。  
  * **行為**：若為 `false`，CA-TRANSLATE 產出的 XS 腳本必須包含註解 `// AUTO-TRADE DISABLED`，且 CA-EXECUTE 禁止發送下單指令至 XQ。  
* **require\_full\_review** (Tier-0)  
  * **定義**：是否強制要求所有產物經過完整人工審查（HITL）。  
  * **預設值**：`true` (REQUIRED)。  
  * **行為**：若為 `true`，GateRunner 在執行 G-HITL-LOG 時，必須檢查 `hitl_handoff.json` 中的 `operator_signature` 欄位。  
* **ict\_hot\_swap\_enabled** (Tier-1)  
  * **定義**：是否啟用 ICT 模組的熱插拔（Hot-Swap）機制。  
  * **預設值**：`false` (DISABLED)。  
  * **修正履歷**：原預設為 true，經 R1 裁決修正為 false 以符合 Safe Default 原則。

#### **3\. 治理規則 (Governance Rules)**

* **SSOT 原則**：ARCH、Runbook 或其他文檔只能 Route-Out 指向 `flag_registry.json`，不得自創同名異義的旗標。違反者觸發 `BLOCK_RELEASE`。  
* **到期清理 (Expiry Policy)**：每個旗標必須定義 `expiry_date`。超過到期日未處理的旗標，系統將強制視為 `RADAR_ONLY` 或 `DISABLED`，防止殭屍代碼殘留。

---

### **2.2.2 Degrade Matrix (降級)：自動化防線與 Fail-Closed**

Degrade Matrix (`degrade_matrix.json`) 定義了系統在遇到異常時的標準反應行為。它將「錯誤處理」從程式碼中的隨機 `try-catch` 提升為架構級的契約，確保系統在部分失效時仍能維持安全或有序停止。

#### **1\. 降級規則表 (Degrade Rules)**

系統預定義了以下核心降級規則（DG-AUTO），涵蓋 LLM、資料品質與緊急狀況。所有規則必須包含觸發條件、降級模式、Fail-Closed 行為與必要日誌。

| Rule ID | 觸發條件 (Trigger) | 降級模式 (Degrade Mode) | Fail-Closed 行為 | 必要日誌 (Required Logs) | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **DG-AUTO-01** | LLM API 連續 3 次調用失敗或超時 | **FALLBACK\_LOCAL** | 禁止進入高風險操作（`EXECUTE_DISABLED`），僅允許本地規則引擎運行 | `error_logdegrade_event` |  |
| **DG-AUTO-02** | 資料品質 Gate (`GATE-DQ`) 驗證失敗（如資料缺漏、格式錯誤） | **BLOCK\_BACKTEST** | 禁止進入回測與訊號生成流程，防止 GIGO (Garbage In, Garbage Out) | `dq_reportgate_fail` |  |
| **DG-AUTO-03** | Kill Switch 被觸發（如虧損達標、API 錯誤） | **EMERGENCY\_STOP** | 全系統暫停，僅保留監控與平倉功能，禁止開新倉 | `kill_switch_logemergency_event` |  |

#### **2\. 降級模式定義**

* **FALLBACK\_LOCAL**：切斷對外部 LLM 的依賴。CA-DISTILL 與 CA-METHOD 將停止使用 AI 生成，改用預定義的靜態模板或規則庫。此模式下產出的 MethodCard 僅供參考，不得用於實盤。  
* **CACHE\_MODE**：當即時資料源（如 XQ API）不穩定時，系統改用本地快取的歷史資料進行模擬或分析，並在 UI 上顯著標示資料延遲警告（`DATA_LAG`）。

#### **3\. 授權與變更**

* 降級規則的變更必須經過 SRS 授權。任何未經授權的降級行為（如私自忽略錯誤）將被視為架構漂移，觸發 `BLOCK_RELEASE`。

---

### **2.2.3 Run Config Snapshot：配置快照與可回放性**

Run Config Snapshot (`run_config_snapshot.json`) 是每次 Pipeline 執行時生成的**不可變配置快照**。它記錄了該次執行當下的所有參數、旗標狀態與環境變數，確保任何一次執行結果都是\*\*可回放（Replayable）**與**可稽核（Auditable）\*\*的。

#### **1\. 核心欄位契約**

Snapshot 必須包含以下最小欄位集合，任一缺失將導致執行失敗（Fail-Closed）：

{  
  "run\_id": "UUID (依據 SFHB v2.1.0 格式)",  
  "timestamp": "ISO8601 時間戳",  
  "trading\_mode": "T0\_DAYTRADE | T1\_SWING",  
  "execution\_mode": "NON\_AGENT | AGENT\_ASSIST",  
  "flag\_values": {  
    "allow\_xsat": false,  
    "require\_full\_review": true,  
    "ict\_hot\_swap\_enabled": false  
    // ... 當下所有 Tier-0/1 旗標的值  
  },  
  "degrade\_mode": "NORMAL | FALLBACK\_LOCAL | EMERGENCY\_STOP",  
  "agent\_config": {  
    "model": "anthropic/claude-3-5-sonnet",  
    "temperature": 0.0  
  },  
  "version\_fingerprint": {  
    "srs\_hash": "sha256:...",  
    "arch\_hash": "sha256:..."  
  },  
  "input\_snapshot\_hash": "sha256:..."  
}

#### **2\. 生成與使用機制**

* **生成時機**：在 `Phase-0: Preflight` 階段，由 CA-GOVERN 依據當前 `flag_registry.json` 與使用者輸入生成。  
* **不可變性**：Snapshot 一經生成即寫入 `/evidence/{run_id}/` 目錄並鎖定，後續流程（Pipeline A/B/C）的所有子系統**必須**讀取此文件作為配置依據，禁止讀取全域配置，以防止「配置漂移（Configuration Drift）」。  
* **證據鏈綁定**：最終產出的 `release_bundle_manifest.json` 必須包含此 Snapshot 的 Hash，證明該次發布是在特定配置下產生的。

#### **3\. Agent 模式綁定**

Snapshot 明確記錄了當次執行的 `execution_mode`。若模式為 `NON_AGENT`，則系統會物理阻斷所有 LLM API 的呼叫嘗試（透過環境變數或 Mock 介面），確保「無 AI」模式的純淨性。

---

## **2.3 Gate 體系 (GateKit)**

本章節詳述 Spartoi-OMOC 架構中的核心治理機制——GateKit。依據「方案 B」的戰略定義，GateKit 不是一個自研的複雜平台，而是一組基於 **GitHub Actions Reusable Workflows** 與 **Composite Actions** 的標準化檢核邏輯。其核心目標是實現「人工只看 PASS」，並透過「雙層架構」與「固定模板」確保所有產出物（Artifacts）皆符合 Fail-Closed 的嚴格標準。  
---

### **2.3.1 Gate 分層架構 (Policy & Check Separation)**

為了避免治理邏輯與檢核細節混淆，系統強制執行「裁決（Policy）」與「檢核（Check）」的分層架構。這是全域級必備原則，任何升級與修補均不得違反。

#### **1\. Layer 1: 裁決層 (Gate Policy)**

裁決層定義了「當檢核失敗時，系統該做什麼」。此層級的狀態是固定的，嚴禁新增第四種狀態。

| Policy 狀態 | 定義與行為 | 適用場景 | 來源 |
| ----- | ----- | ----- | ----- |
| **BLOCK\_RELEASE** | **阻斷發布**。視為 P1 階段未完成，禁止進入下游管線，不得宣稱任務完成。CI/CD 流水線必須回報 Failure 並終止運行。 | 關鍵安全漏洞、合規失敗、Schema 驗證失敗、Evidence 缺失。 |  |
| **RADAR\_ONLY** | **僅觀測**。允許繼續執行並產出工件，但必須在報告中標記風險（Warning）。禁止進入 EXECUTE（下單）路徑。 | 非關鍵品質指標（如註解率）、效能輕微退化、候選（Candidate）門檻未達標。 |  |
| **EXECUTE\_DISABLED** | **禁用執行**。系統可運行但禁用高風險動作（如 Kill-Switch 觸發、HITL 未確認）。此狀態下，交易功能被物理鎖死。 | Kill-Switch 觸發、台股微結構（TWMS）三軸檢查失敗。 |  |

#### **2\. Layer 2: 檢核層 (Gate Check)**

檢核層是具體的執行邏輯，由 `gate_id` 標識。每個 `gate_id` 必須映射到唯一的 `gate_policy`，嚴禁混用。

* **擴展性**：`gate_id` 可依需求擴展（例如 `GATE-RL-001`、`GATE-TWMS-001`），但其最終裁決必須回歸到上述三種 Policy 之一。  
* **職責分離**：P1 階段負責產出「合約與證據鏈」（寫入 `gate_result.json`），P2 階段負責將 Policy 接到運行期行為（如 CI 阻斷）。

### **2.3.2 8 Gate 模板 (The 8 Templates)**

為了防止治理體系無限膨脹，本架構 **鎖定** 使用 8 個標準化 Gate 模板。不得新增第 9 個模板，任何新的檢查需求必須歸類至現有模板中。

這些模板直接對應到 GMA Lite 的「六件套」邏輯 與 Spartoi 的業務需求：

| Gate ID | 名稱 | 核心檢核邏輯 (Judgment Logic) | Fail-Closed 行為 | 對應 GMA/OMOC 機制 | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **G-SRC** | **來源完整性 Gate** | 檢查 `No-Source-No-Norm`、必填欄位存在、引用鏈（Citation Chain）可解析。 | **BLOCK\_RELEASE** | G0 Input Seal / Provenance |  |
| **G-SCHEMA** | **Schema 合規 Gate** | 執行 JSON Schema 校驗，確保 `additionalProperties: false`（無非法欄位）。 | **Fail-Closed** (阻斷) | Contract-First / Spec Mode |  |
| **G-BT-H** | **回測健康度 Gate** | 檢查回測報告存在、口徑一致、無前視偏誤（Lookahead Bias）或數據洩漏。 | **CONDITIONAL** (警告) | Reliability / Test Gate |  |
| **G-SEG-L** | **語意保真 Gate** | 透過 Golden Set 抽樣比對，確保蒸餾/轉譯過程無關鍵矛盾或遺漏。 | **Fail \+ Drift Log** | Semantic Fidelity |  |
| **G-CONF-L** | **覆蓋率/信賴度 Gate** | 檢查準確度（Accuracy）是否達標、最小樣本量（N\_min）是否足夠。 | **CONDITIONAL** (CR\_OPEN) | Confidence Score |  |
| **G-XQ-PARITY** | **XQ 一致性 Gate** | 驗證 XS 腳本可編譯、訊號與本地邏輯等價（Signal Parity）、模擬交易通過。 | **Fail-Closed** | TVE (Translation-Verification) |  |
| **G-HITL-LOG** | **HITL 日誌 Gate** | 檢查 `hitl_handoff` 文件存在，且包含人工確認紀錄（APPROVED/REJECTED）。 | **BLOCK\_RELEASE** | Human-in-the-Loop / Safety |  |
| **G-RUN** | **可執行 Gate** | 確保流程可一鍵跑通、環境指紋（Env Fingerprint）一致、符合 No-API 基線。 | **Fail-Closed** | Reproducibility / Build Gate |  |

### **2.3.3 GateRunner (最薄執行器)**

GateRunner 是 GateKit 的執行引擎。在「方案 B」架構下，它不是一個龐大的平台，而是一個輕量級的 Python 腳本或 Composite Action，負責執行檢核並產出標準化證據。

#### **1\. 執行邏輯與職責**

GateRunner 嚴格遵循「讀取 → 執行 → 產出」的單向流程：

1. **讀取**：讀取 `manifest.json`（包含輸入檔案路徑與 Hash）。  
2. **執行**：依據指定的 Gate 模板（如 `G-SCHEMA`）載入對應的 Schema 或腳本進行檢核。  
3. **產出**：生成「證據三件套」（Evidence Triad）。

#### **2\. 證據三件套 (Evidence Triad)**

每次 Gate 執行 **必須** 產出以下三份文件，缺一即視為 Fail-Closed：

* **`manifest.json`**：記錄 Run ID、Git SHA、輸入/輸出檔案的 Hash、以及環境指紋。  
* **`gate_report.json`**：記錄每個 Check 的結果（PASS/FAIL）、違反的規則細節、以及 Policy 裁決結果。  
* **`artifacts/`**：實際產出的工件（如驗證過的 JSON、報告、日誌）。

#### **3\. 工程結構**

GateRunner 的實體檔案結構應位於專案根目錄的 `/gates/` 下：

/gates/  
├── schemas/          \# 存放 artifact\_manifest, gate\_report 等 JSON Schema  
├── runner/           \# 執行腳本 (gate\_runner.py, run\_gates.ps1)  
├── templates/        \# 8 個 Gate 的 YAML 定義檔 (G-SRC.template.yaml 等)  
├── golden\_set/       \# 用於 G-SEG-L 的抽樣驗證集  
└── reports/          \# 執行報告輸出區

#### **4\. 異常處理 (Error Handling)**

GateRunner 必須具備明確的錯誤代碼與恢復流程：

* **ERR-GR-001 (Manifest 解析失敗)**：阻斷所有下游 Gate。  
* **ERR-GR-003 (證據檔案缺失)**：阻斷該 Gate。  
* **ERR-GR-004 (Schema 校驗失敗)**：Fail-Closed，記錄驗證錯誤。  
* **ERR-GR-009 (外部依賴失敗)**：若是 API 呼叫失敗，可降級執行（RADAR\_ONLY），但必須記錄依賴錯誤。

透過此三層結構（分層架構、8 模板、GateRunner），Spartoi-OMOC 實現了將業務邏輯（如台股規則）與執行工具（OpenCode/GitHub Actions）的完美解耦與強制治理。

---

## **3\. 執行平面：OMOC 引擎配置 (Execution Plane)**

本章節確立「執行平面 (Execution Plane)」的物理基礎與配置規範。依據《Spartoi-OMOC\_開發實作方案.md》，執行平面被定義為系統的「油門」與「工廠」，負責運行 Agent Skills、生成文檔與執行代碼修改。為了消除「在我的機器上可以跑」的環境漂移，本指南強制要求環境標準化，並以 **OpenCode** 作為核心運行時 (Runtime)。  
---

## 3.1 環境與運行時 (Environment & Runtime)

為了支援多模型協作的運算需求並滿足 Spartoi 架構對於「可重現性 (Reproducibility)」的嚴格要求，本節定義了不可協商的安裝標準與運行環境配置。  
---

#### **3.1.1 OpenCode CLI 安裝與依賴 (OpenCode CLI)**

OpenCode CLI 是本架構底層的 AI 編碼代理運行時，支援 75+ 模型供應商接入。為確保自動化骨架「方案 B」的穩定執行，必須遵循以下安裝規範：

* **Node.js 環境鎖定**：  
  * **版本要求**：宿主環境必須安裝 **Node.js 18** 或更高版本，以避免運行時錯誤。  
  * **驗證指令**：執行 `node -v` 確認版本符合要求。  
* **OpenCode CLI 安裝**：  
  * **標準指令** (macOS/Linux)：`curl -fsSL https://opencode.ai/install | bash`。  
  * **GitHub Agent 整合**：針對 CI/CD 環境，可透過 `opencode github install` 進行配置。  
  * **非互動模式 (Non-interactive Mode)**：在 GitHub Actions 等自動化流水線中，必須使用 CLI 的非互動模式（如 `opencode run "prompt"` 或 `-p` 參數），確保指令直接傳遞給 AI 處理並在完成後自動退出，避免 TUI 介面卡死流水線。  
  * **CI/CD 環境變數強制配置：**  
        \*   為防止流水線因互動提示或背景更新而卡死，\*\*必須\*\* 在 Workflow 的 \`env\` 或 \`step\` 中設定以下變數 \[8\]：  
      
    \`\`\`yaml  
    env:  
      \# \[Critical\] 防止 CI 過程中因檢查更新導致連線逾時或中斷  
      OPENCODE\_DISABLE\_AUTOUPDATE: "true"  
      \# \[Debug\] 強制將 Agent 思考過程輸出至 stderr，便於事後故障排除  
      OPENCODE\_PRINT\_LOGS: "true"  
      \# \[Safety\] 設定 Bash 執行超時上限 (預設 60秒)  
      OPENCODE\_EXPERIMENTAL\_BASH\_DEFAULT\_TIMEOUT\_MS: "60000"  
* **執行器選擇 (Bun)**：  
  * 雖然可使用 npm/npx，但實測顯示 npx 在處理 OMOC 插件依賴時可能不穩定。本指南強烈建議使用 **Bun** 作為執行器，並透過 `bunx oh-my-opencode install` 進行 OMOC 插件安裝。

#### **3.1.2 配置文件規範 (Configuration: opencode.json)**

`opencode.json` 是定義 Agent 行為、權限邊界與模型選用的核心文件。為了實現「方案 B」的自動化骨架，配置必須精確控制。

* **配置層級與優先序 (Precedence Order)**： OpenCode 依序載入以下配置，後載入者覆蓋前者（由低至高）：  
  * **Remote config**：來自 `.well-known/opencode` 的組織級預設。  
  * **Global config**：`~/.config/opencode/opencode.json`（使用者偏好）。  
  * **Project config**：專案根目錄的 `.opencode/opencode.json`（**最高優先級**，應納入版本控制）。  
* **Agent 行為定義**：  
  \*   \*\*權限控制 (Permissions)\*\*：  
      \*   \*\*v1.1.1 新語法\*\*：必須使用 \`permission\` 物件定義工具存取層級（allow/ask/deny）。舊版 \`tools\` 布林值已失效 \[1\]\[2\]。  
      \*   \*\*CI 環境配置\*\*：在自動化流水線中，必須明確授權必要工具（如 \`bash\`, \`write\`），並封鎖高風險操作。  
      \*   \*\*安全紅線\*\*：必須利用 \`read\` 的細粒度規則將 \`.env\` 列入 deny 名單，防止 AI 意外讀取敏感憑證 \[7\]。  
    
  \*\*opencode.json (CI Profile) 範例：\*\*  
  \`\`\`json  
  {  
    "$schema": "https://opencode.ai/config.json",  
    "permission": {  
      "bash": "allow",      // CI 環境允許執行腳本  
      "edit": "allow",      // 允許代碼修改 (write/patch)  
      "read": {  
        "\*": "allow",  
        "\*\*/.env\*": "deny"  // \[P0\] 強制封鎖敏感配置檔讀取  
      },  
      "webfetch": "deny"    // \[P0\] 禁止 CI Agent 連網抓取外部資料  
    }  
  }  
* **模型配置 (Model Selection)**：  
  * 可透過 `provider` 與 `model` 選項指定後端模型（如 `anthropic/claude-sonnet-4-5`），或針對不同 Agent 覆蓋模型設定。

#### **3.1.3 Codespaces 固化 (Codespaces Solidification)**

為了滿足 Spartoi 架構中「唯一可重現沙盒」的要求，**GitHub Codespaces** 被指定為標準開發與執行環境。這不僅是為了便利，更是為了鎖定工具鏈版本與解決認證問題。

* **環境一致性鎖定**：  
  * **.devcontainer 配置**：必須在 `.devcontainer/devcontainer.json` 中嚴格鎖定基礎映像檔 (Image)、Node.js 版本、OpenCode CLI 版本與 OMOC 插件版本。這是防止「在我的機器上可以跑」這類環境漂移的物理防線。  
* **自動化初始化 (Lifecycle Hooks)**：  
  * 利用 `postCreateCommand` 鉤子自動執行 `npm install`、`bunx oh-my-opencode install` 及 `/init` 指令，確保環境啟動即用，無需人工介入配置。  
* **持久化會話 (Persistent Sessions)**：  
  * **解決認證卡死**：在無頭 (Headless) 的 CI/CD 環境中，CLI 工具無法進行互動式認證。Codespaces 容器支援存儲持久化，可用於快取 CLI 工具的憑證（如 `~/.codex/auth.json`），實現免 API Key 的自動化執行，並將互動式認證任務與 CI/CD 物理隔離。

---

## **3.2 Agent 4 線模組化配置 (4-Lanes via Modes)**

本章節依據《Spartoi-OMOC\_開發實作方案.md》與《Spartoi-OMOC 工程實作指南：目錄（TOC）》，詳述如何利用 OpenCode 的 Agent 配置機制，將 Spartoi 系統的「四條變形泳道 (4 Lane Profiles)」落地為可執行的工程配置。此架構不建立四個獨立的 Repository，而是利用 OpenCode 的 modes 與 agents 設定，在單一專案中實現 Vibe、Spec、Dev、Ops 四種截然不同的行為模式與治理強度。  
---

### **3.2.1 配置結構 (Configuration Structure)**

為了實現泳道隔離與可重現性，本指南強制採用「1 套 OpenCode \+ 4 份配置」的策略。開發者只需切換 Agent（Mode），即可無縫切換當下的治理強度與技能組合。

* **目錄結構標準 (Directory Standard)**： 所有 Agent 定義檔必須置於專案根目錄的 `.opencode/agents/` 下，並與 `.opencode/modes/` 配合使用。  
* **核心配置檔案 (Core Configuration Files)**： 必須建立以下四份定義檔，分別對應四條泳道：  
  * **`vibe.md` (Vibe Mode)**：探索與原型模式。低 Gate，允許快速迭代與發散思考，適用於 POC 階段。  
  * **`spec.md` (Spec Mode)**：規範與契約模式。契約優先 (Contract-First)，掛載 DocOps 技能，負責產出 SSOT (Single Source of Truth)。  
  * **`dev.md` (Dev Mode)**：實作與修復模式。嚴格遵循 TDD (測試驅動開發) 循環，掛載 Lint 與 Test 技能。  
  * **`ops.md` (Ops Mode)**：運維與發布模式。權限較高，掛載 Release 技能，但在 Spartoi 架構中受到最嚴格的 HITL (Human-in-the-Loop) 限制。

### **3.2.2 Spec Mode (規範)**

此模式是系統的立法機關，專注於產出精確、不遺漏且可追溯的規範文檔。

* **定位 (Positioning)**： 專注於產出系統的單一真相來源 (SSOT)。此模式追求精確與契約優先，負責生成 SRS、ARCH、LBP 等核心文件。  
* **配置特徵 (Configuration)**：  
  * **Temperature**：嚴格鎖定為 **0.0 \- 0.1**，確保輸出具備確定性 (Deterministic)。  
  * **Persona**：注入「技術作家 (Technical Writer)」與「審計員 (Auditor)」人格，強調 "No-Source-No-Norm"（無來源即無規範）原則。  
* **技能掛載 (Mounted Skills)**：  
  * **`skill.normalize`**：將雜亂輸入轉化為結構化原子 (Atoms)。  
  * **`skill.trace`**：建立需求與產出的雙向追蹤矩陣。  
  * **DocOps Toolchain**：`docs_build` (MkDocs Strict)、`lint_markdown` (markdownlint)、`check_links` (Lychee)、`lint_style_terms` (Vale)。  
* **輸出要求 (Outputs)**： 必須產出 `normalized.jsonl` 與 `trace_map.json`。若文檔覆蓋率 (Coverage) 低於 98%，此模式下的任務視為失敗。

### **3.2.3 Dev Mode (實作)**

此模式是系統的工廠，負責將 Spec Mode 產出的規格落地為可通過測試的程式碼。

* **定位 (Positioning)**： 代碼與測試閉環。嚴格遵循 **TDD (測試驅動開發)** 循環，並整合 Linting 與自動修復。  
* **配置特徵 (Configuration)**：  
  * **Temperature**：設定為 **0.2 \- 0.3**，在精確實作與代碼優化間取得平衡。  
  * **Persona**：注入「資深工程師 (Senior Engineer)」人格，強制執行「紅-綠-藍 (Red-Green-Refactor)」循環。  
* **技能掛載 (Mounted Skills)**：  
  * **`tdd-workflow`**：強制執行「先寫測試，再寫代碼」的流程。  
  * **`MegaLinter`**：一包搞定所有語言的 Lint/Format 檢查，取代零散的 Style Guide。  
  * **`skill.ci-fix`**：讀取 CI 錯誤日誌並自動嘗試修復，直到測試通過。  
* **治理機制 (Governance)**：  
  * **Ralph Loop**：啟用自動收斂引擎，設定 `max_iterations` (如 5 次)，防止 Agent 陷入無限修補的死循環。  
  * **Scope Lock**：限制寫入範圍僅於 `src/` 與 `tests/`，**嚴禁修改** `.github/` 或 `docops/` 配置。

### **3.2.4 Ops Mode (運維)**

此模式是系統的控制室，負責執行 Runbook、基礎設施變更與發布，具備最高權限但也受最嚴格監管。

* **定位 (Positioning)**： Runbook 驗證、發布管理、基礎設施代碼 (IaC) 執行。  
* **配置特徵 (Configuration)**：  
  * **High Privilege**：允許執行 Shell 指令與存取特定基礎設施工具。  
  * **Constraint**：在 Spartoi 架構中，Ops Mode **預設禁用 Cowork (Cowork Disabled)**，防止未經驗證的協作內容直接影響生產環境。  
* **技能掛載 (Mounted Skills)**：  
  * **CLI Tools**：`gh-cli` (GitHub CLI)、`aws-cli` 等運維工具。  
  * **Release Skills**：掛載發布相關的自動化技能。  
* **紅線 (Red Lines)**：  
  * **XQ 唯一下單端**：Ops Mode 僅能執行本地系統維護與指令生成，**嚴禁** 觸發任何直接對接券商 API 的自動下單動作。  
  * **HITL 強制介入**：所有涉及 `CA-EXECUTE` 或資金操作的步驟，必須經過人工確認。

---

## **3.3 技能生態 (Skill Ecosystem)**

本章節依據《Spartoi-OMOC 工程實作指南：目錄（TOC）》與《OMOC-GMA Lite 實作指南》，定義系統如何管理、分發與執行 AI 代理技能（Skills）。在 Spartoi 架構中，技能被視為「可重用的自動化單元」，必須受到與程式碼同等級別的供應鏈治理。  
---

### **3.3.1 Skilz-CLI：套件管理與供應鏈治理 (Package Management & Governance)**

為了防止「依賴崩潰」與「惡意指令注入」，本架構拒絕隨意使用 `npm install` 或網路動態加載技能，而是採用 **Skilz-CLI** 進行嚴格的白名單與版本鎖定管理。

* **Registry 作為唯一真理 (SSOT)**：

  * **機制**：專案根目錄下的 `.skilz/registry.yaml` 是技能來源的唯一合法清單。  
  * **白名單策略**：Agent 僅被允許安裝此清單中明確定義的技能 ID。若請求安裝未註冊的技能，系統必須執行 **Fail-Closed** 阻斷並回報錯誤。  
  * **Skill Curator**：指派專門的 `Skill Curator Agent` 負責維護此檔案，人類開發者僅需審核其提交的 PR。  
* **版本鎖定 (Pinning)**：

  * **強制 SHA**：所有註冊的技能必須鎖定在特定的 40 位元 Git Commit SHA（例如 `git_sha: ee131b...`）。  
  * **禁止 Latest**：嚴禁使用 `@latest`、`@main` 或語義版本（SemVer）範圍，以防止上游供應鏈投毒或非預期變更導致流水線崩潰。  
* **審計與證據 (Manifest)**：

  * **產出物**：每次安裝或更新技能後，系統必須自動生成或更新 `.skilz-manifest.yaml`。  
  * **內容**：包含 `installed_at`、`git_repo`、`skill_path` 與當下的 `git_sha`。此檔案作為 Artifact Attestations 的輸入，確保執行環境的可追溯性。

### **3.3.2 Spartoi MVS：最小可行技能集 (Minimum Viable Skills)**

依據《Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI》定義的 **MVS (Minimum Viable Skills)**，本架構僅允許加載經過驗證的「核心技能」，並嚴格執行 **「技能不當裁判 (Skills Not Judge)」** 原則。

* **核心原則**：

  * **角色定位**：Skills 是「製作工（Maker）」，負責產出工件、整理格式或組裝檔案。  
  * **權限限制**：Skills **禁止** 直接判定 PASS/FAIL。判定的權力專屬於 **GateRunner** 與 **GateKit**。若 Skills 輸出包含判定結果，該結果僅視為參考，不具備合規效力。  
* **MVS 清單與狀態**：

   | Skill ID | 用途 | 狀態 | Gate 綁定 | 來源 | | :--- | :--- | :--- | :--- | :--- | | **spartoi-schema** | **Schema 驗證**。自動校驗 JSON/YAML 是否符合 ICD 規範。 | **定案 (DEFINED)** | G-SCHEMA | | | **spartoi-evidencepack-builder** | **三件套組裝**。自動彙整 manifest, gate\_report, artifacts。 | **CR\_OPEN-019** (暫結案) | G-RUN | | | **spartoi-gatekit-runner** | **Gate 執行**。呼叫 GateRunner 執行檢核邏輯。 | **CR\_OPEN-021** (候選) | G-RUN | |

* **執行規格**：

  * **spartoi-schema**：輸入必須包含 `file_path` 與 `schema_ref`，輸出必須包含 `validation_result` 與 `errors` 清單。  
  * **失敗處置**：若 `evidencepack-builder` 執行失敗，需標記為 `INCOMPLETE` 並要求人工補齊（CR\_OPEN-019）。

### **3.3.3 Input Trust Tier：輸入信任分級策略 (Input Trust Tier Policy)**

為了防禦 **Prompt Injection** 與 **Data Exfiltration**（OWASP LLM Top 10 核心風險），本架構對所有輸入資料實施嚴格的信任分級（Trust Tiering）。Agent 在處理資料前，必須先驗證其信任等級。

* **分級定義 (Tier Definition)**：

   | 等級 | 定義 | 來源範例 | 權限 (Cowork/Skills) | 來源 | | :--- | :--- | :--- | :--- | :--- | | **L0 (Trusted)** | 內部產出、已驗證 | Evidence Pack、已合併的主幹 PR | Read / Write / Transform | | | **L1 (Internal)** | 內部未驗證 | 草稿、Staging 區產物 | Read / Transform | | | **L2 (External-sanitized)** | 外部已淨化 | 經 Sanitizer 工序清洗過的外部文件 | Read-only | | | **L3 (Untrusted)** | 外部未淨化 | 任意網路下載文件、未經審核的 Issue | **REJECT (拒收)** | |

* **執行點 (Enforcement)**：

  * **指令**：`validate --policy trust_tier`。  
  * **行為**：系統在處理輸入前檢查標記。若發現 L3 等級資料直接進入處理流程，必須立即執行 **BLOCK\_RELEASE**。  
  * **淨化流程 (Sanitization)**：L3 資料必須經過明確定義的 Sanitizer 工序（如轉為純文字、移除腳本標籤）並重新標記為 L2 後，方可被 Agent 讀取。

### **3.3.4 技能結構與動態編排 (Structure & Orchestration)**

本節規範 Skill 的物理結構與運行時載入機制，確保在不造成 Context Window 爆炸的前提下，提供 Agent 所需的能力。

* **標準目錄結構**：

  * 每個 Skill 必須擁有獨立目錄（如 `.opencode/skills/<skill-id>/`）。  
  * **SKILL.md**：核心定義檔，包含 Frontmatter（元數據）與 Instructions（指令正文）。  
  * **scripts/**：存放實際執行的 Python/Shell 腳本，Agent 透過調用這些腳本與系統互動，而非僅依賴 LLM 生成指令。  
* **漸進式披露 (Progressive Disclosure)**：

  * **機制**：OpenCode 啟動時僅載入 Skill 的 Metadata（名稱與描述）。只有當 Agent 決定調用特定技能時，系統才讀取其完整 Instructions 並注入 Context。  
  * **目的**：節省 Token 消耗，防止因工具定義過多導致模型注意力渙散（Context Bloat）。  
* **動態編排**：

  * 基於 **OMOC v3.0.0** 架構，任務執行不依賴單一通才 Agent。**Sisyphus (主控)** 會根據任務屬性（如「需要查詢文檔」或「需要執行測試」），動態從 Registry 中選取並掛載對應的 Skill 組合。

---

## **4\. 領域實作：15 CA 工作站 (15 CA Stations)** ---

## 4.1 工作站標準結構 (Station Standard Structure)

本章節定義如何將 Spartoi 架構中的 15 個邏輯子系統（CA-Subsystems），轉化為工程實作上的「標準化工作站（Standardized Workstations）」。依據「方案 B」的戰略定義，所有 CA 子系統必須被視為「參數化」的執行單元，透過統一的介面合約接入單一流水線（Single Pipeline），嚴禁各子系統各自發展獨立的 CI/CD 框架或異質的目錄結構 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_ARCH\_v6[.0.0-r5.md](http://.0.0-r5.md)\]。  
---

#### **4.1.1 目錄規範與適配層 (Directory Protocol & Adapter Layer)**

為了實現「單一流水線」調度 15 種不同性質（如 WRC 的爬蟲、METHOD 的邏輯、TRANSLATE 的轉譯）的任務，工程架構上必須建立一層「適配層（Adapter Layer）」。

* **物理結構（Repo Layout）**：

  * 依據《Spartoi-OMOC\_開發實作方案.md》，Repo 根目錄下必須建立 `ca/` 目錄，內含以 `CA_ID` 命名的子目錄（如 `ca/CA-WRC/`, `ca/CA-EXECUTE/`）。  
  * **核心內容**：每個 CA 工作站目錄下 **僅允許** 包含以下三類檔案，禁止包含獨立的 `.github/workflows`：  
    1. **`station.config.yaml`**（或 `task_manifest.yaml`）：定義該工作站的執行參數、所需權限與模型配置 \[Spartoi-OMOC\_開發實作方案.md\]\[OMOC-GMA Lite 實作指南.md\]。  
    2. **`adapters/`**：存放將流水線標準輸入轉換為該 CA 核心邏輯所需的腳本（如 `input_adapter.py`），以及將產出標準化為 Evidence Pack 的腳本（如 `evidence_packer.py`）\[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
    3. **`prompts/`**（可選）：若該 CA 涉及 Agent 運作，存放專用的 Prompt 模板 \[Spartoi-OMOC\_開發實作方案.md\]。  
* **邏輯映射（Logical Mapping）**：

  * `ca/<CA_ID>/` 僅作為 **CI/CD 的掛載點（Mount Point）**。實際的業務邏輯代碼（Core Logic）應保留在 `spartoi_p1/` 的源碼目錄中（如 `spartoi_p1/knowledge/wrc/`），透過 Adapter 進行呼叫，保持「業務邏輯」與「執行設施」的分離 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **反漂移約束**：

  * 嚴禁在 `ca/<CA_ID>/` 下建立獨立的 `pipeline.yml` 或 `Makefile`，所有構建與測試指令必須封裝在 Adapter 中，由全域流水線統一觸發 \[Spartoi-OMOC\_開發實作方案.md\]。

#### **4.1.2 I/O 契約與證據三件套 (I/O Contract & Evidence Trinity)**

依據「方案 B」的「控制面最小不變量（Control Plane Minimum Invariant）」原則，所有 CA 工作站必須遵守統一的輸入/輸出契約。流水線不關心 CA 內部是如何運作的（黑箱），只關心是否產出了合規的證據包（Evidence Pack）\[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。

* **必備產出（The Trinity）**：每個 Job 執行結束時，Adapter 必須生成以下三個 JSON 檔案，缺一即視為 **BLOCK\_RELEASE**：

  * **`inputs_manifest.json`**：

    * **職責**：記錄本次執行的「輸入快照」，包括資料版本（Hash）、策略版本、運行參數（Flags）與執行模式（RADAR\_ONLY/EXECUTE\_DISABLED）。  
    * **目的**：確保「可重現性（Reproducibility）」，防止因輸入漂移導致的不可解釋結果 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。  
  * **`evidence_manifest.json`**（或 `evidence_index.json`）：

    * **職責**：列出本次執行產出的所有關鍵工件（Artifacts）及其 SHA-256 雜湊值。例如：`backtest_report.json`, `xs_script.txt`, `run.log`。  
    * **目的**：建立「可追溯性（Traceability）」，確保產物未被篡改 \[Spartoi-OMOC\_開發實作方案.md\]\[OMOC-GMA Lite 實作指南.md\]。  
  * **`verdict.json`**：

    * **職責**：機器可讀的最終裁決結果。必須明確包含 `overall_status` (PASS/FAIL) 與 `gate_results`。  
    * **限制**：此檔案必須由確定性的代碼（Deterministic Code）生成，**嚴禁由 LLM 生成**，以防止 AI 幻覺導致的虛假放行 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi-OMOC\_開發實作方案.md\]。  
* **Fail-Closed 機制**：

  * 若流水線在 `artifacts/` 目錄中找不到上述任一檔案，或 JSON Schema 驗證失敗，系統將自動標記該 Job 為失敗，並阻斷後續流程 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[OMOC-GMA Lite 實作指南.md\]。

#### **4.1.3 參數化驅動與任務清單 (Parameterization & Task Manifest)**

為了消除重複的 CI 設定檔，CA 工作站的行為由 **`station.config.yaml`**（或 `task_manifest.yaml`）定義，流水線透過讀取此設定檔動態決定執行邏輯 \[Spartoi-OMOC\_開發實作方案.md\]\[OMOC-GMA Lite 實作指南.md\]。

* **設定檔欄位規格**：

  1. **`ca_id`**：子系統 ID（如 `CA-TRANSLATE`），必須對應 ARCH 白名單 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  2. **`lane_profile`**：指定執行泳道（Spec / Dev / Ops），決定掛載的 Skill Set 與權限等級 \[OMOC-GMA Lite 實作指南.md\]。  
  3. **`required_skills`**：列出執行所需的 OMOC Skills（如 `spartoi-schema`, `spartoi-evidence-pack`），且必須指定版本 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  4. **`gate_binding`**：指定該工作站必須通過的 Gate ID（如 `G-XQ-PARITY`），用於 GateRunner 執行驗收 \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
* **執行流程**：

  1. **Orchestrator** 讀取 `station.config.yaml`。  
  2. **Dispatcher** 根據 `lane_profile` 分派到對應的環境（Container/Runner）。  
  3. **Loader** 根據 `required_skills` 從 Registry 安裝指定版本的 Skills。  
  4. **Runner** 執行 Adapter 腳本，產出證據三件套 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

---

## **4.2 知識管線 (Pipeline A: SpecPack)**

本章節依據《Spartoi-OMOC\_開發實作方案.md》定義的「方案 B」架構，詳述 **Pipeline A (SpecPack)** 的工程實作細節。此管線負責將非結構化的 ICT 教材轉化為結構化、可驗證的偽代碼原語（Primitives），是系統的「知識上游」。

---

### **4.2.1 管線架構與職責定義 (Pipeline Architecture)**

Pipeline A 由四個線性執行的 CA 工作站組成，採用「單一流水線」串接，透過 GitHub Actions 的 `workflow_call` 機制調度。

* **流程順序**：`CA-WRC` → `CA-CORPUS` → `CA-DISTILL` → `CA-DSL` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **輸入 (Inputs)**：`ICT_PDF_POINTERS`（教材 PDF 路徑清單）、`corpus_config.yaml` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **輸出 (Outputs)**：`SpecPack/<specpack_id>/`，包含以下核心工件：  
  * `input_manifest.json` (來源清單)  
  * `corpus_snapshot.json` (語料快照)  
  * `distill_bundle.json` (蒸餾包)  
  * `dsl_schema.json` (原語定義) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi-OMOC\_開發實作方案.md\]。  
* **Gate 綁定**：  
  * **G-SRC**：驗證來源完整性。  
  * **G-SEG-L**：驗證語意保真度（SGF）。  
  * **G-SCHEMA**：驗證結構完整性 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

---

### **4.2.2 CA-WRC 工作站：教材蒐集 (Source Ingestion)**

**核心職責**：作為知識管線的入口，負責匯入白名單教材資源，並產生不可篡改的輸入清單 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

* **MVP 最小行為 (Minimum Behavior)**：

  * **Input**：ICT PDF 檔案路徑清單。  
  * **Process**：計算檔案雜湊（Hash）、驗證白名單狀態、去重。  
  * **Output**：`/outputs/input_manifest.json` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **驗證標準 (Verify Min)**：

  * `input_manifest.json` 必須存在。  
  * 每個 PDF 必須有對應的 SHA-256 Hash。  
  * 清單中無重複檔案 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Fail-Closed 停止線 (Stopline)**：

  * 若任一 PDF 無法讀取 → **STOP**，列出錯誤清單。  
  * 若 Hash 計算失敗 → **STOP**，阻斷進入下游 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi-OMOC\_開發實作方案.md\]。  
* **ADR 決策支撐**：

  * 依據 **ADR-016**，WRC 必須執行雙路來源（人工/自動）的白名單審核，確保無汙染源進入系統 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。

---

### **4.2.3 CA-CORPUS 工作站：語料庫構建 (Knowledge Base)**

**核心職責**：將原始教材轉化為結構化、可檢索的索引，支援多模態（文字/表格/圖表/影片）處理 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

* **MVP 最小行為**：

  * **Input**：`input_manifest.json`。  
  * **Process**：建立檢索索引（Indexing）、分段（Chunking）、產生快照。  
  * **Output**：`/outputs/corpus_snapshot.json` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **多模態架構 (Multi-Modal Pipeline)**：

  * 依據 **ADR-011** 與 **ARCH §4.2.5**，系統需自動路由處理四種路徑：  
    1. **文字路徑**：純文字 PDF/MD → chunks.jsonl。  
    2. **表格路徑**：Excel/CSV → structured\_data.jsonl。  
    3. **圖表路徑**：Vision Model → figure\_desc.jsonl。  
    4. **影片路徑**：Video Transcriber → video\_chunks.jsonl \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。  
* **Provenance 驗證**：

  * 入庫教材必須帶有 Provenance（source\_id, author, date, hash），缺一即拒絕入庫並寫入 `corpus_rejection_log.json` \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **Fail-Closed 停止線**：

  * 若索引建立失敗 → **STOP**。  
  * 若覆蓋率 \< 100%（有 PDF 未索引）→ **RADAR\_ONLY**，標記遺漏風險 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

---

### **4.2.4 CA-DISTILL 工作站：語意蒸餾 (Semantics Extraction)**

**核心職責**：利用 LLM 進行「三層蒸餾（SEM³）」，從語料庫中提取偽代碼、概念與規則，產出蒸餾包 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

* **MVP 最小行為**：

  * **Input**：`corpus_snapshot.json`。  
  * **Process**：執行 LLM 蒸餾（Sparse → Enrich → Multi-view）、執行 SGF Gate (SEG-Lite) 驗證。  
  * **Output**：`/outputs/distill_bundle.json` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **SEM³ 三層蒸餾架構**：

  * 依據 **ADR-009**，蒸餾過程必須遵循 **SGF (Source-Grounded Faithfulness)** 驗證。  
  * **SGF Gate**：檢查蒸餾產物對原教材的語意忠實度。若 `fidelity_score` 低於門檻（Candidate 值需經 CR\_OPEN 確認），則標記為 FAIL \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **No-Paid-LLM-API 約束**：

  * 蒸餾過程的主路徑必須支援 **No-API 模式**（如使用本地模型或 WebTools-NA 協作），雲端付費 API 僅可作為可選加速 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **Fail-Closed 停止線**：

  * 若 Golden Set 抽樣失敗 → **STOP**，診斷語意偏差。  
  * 若發現關鍵矛盾 → **STOP**，人工裁決。  
  * 若遺漏率 \> 10% → **RADAR\_ONLY** \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

---

### **4.2.5 CA-DSL 工作站：原語標準化 (Primitive Standardization)**

**核心職責**：將蒸餾出的概念標準化為市場中立的「純原語（Pure Primitives）」，並維護 MarketProfile SSOT \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

* **MVP 最小行為**：

  * **Input**：`distill_bundle.json`。  
  * **Process**：選擇候選結構、驗證 Schema 完整性、產生 DSL Schema。  
  * **Output**：`/outputs/dsl_schema.json`, `/outputs/baseline_v1.vpc.yaml` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **純原語政策 (Pure Primitives)**：

  * 依據 **ADR-036**，CA-DSL 只承載語法單元、運算子與容器。  
  * **嚴禁**：在 DSL 原語中硬編碼台股特定常數（如 09:00-13:30、漲跌幅 10%）。這些常數必須置於 **MarketProfile** 中管理 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **MarketProfile SSOT**：

  * MarketProfile.json 為市場常數的唯一來源，由 CA-DSL 管轄，CA-GOVERN 負責更新 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **Fail-Closed 停止線**：

  * 若 Schema 結構不完整 → **STOP**。  
  * 若函數簽名缺失 → **STOP** \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

---

### **4.2.6 Evidence Pack 與驗收 (Evidence & Acceptance)**

Pipeline A 的執行結果必須產出完整的 Evidence Pack，以滿足「人工只看 PASS」的稽核要求。

* **Evidence Triad (三件套)**：

  * **manifest.json**：記錄 run\_id、pipeline\_id (A)、operator、inputs/outputs hash。  
  * **gate\_report.json**：記錄 G-SRC、G-SEG-L、G-SCHEMA 的判定結果與詳細日誌。  
  * **artifacts/**：包含 `corpus_snapshot`, `distill_bundle`, `dsl_schema` 等實體檔案 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Handoff Contract (交接契約)**：

  * Pipeline A 完成後，產出 `SpecPack` 並透過 PR/Tag (例如 `specpack/<id>`) 進行交接。  
  * 下游 Pipeline B (Strategy) 必須透過 Manifest 引用此 SpecPack，禁止直接讀取中間檔案 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi-OMOC\_開發實作方案.md\]。  
* **驗收門檻**：

  * 所有 Gate 必須 PASS（或標記 RADAR\_ONLY）。  
  * Manifest 必須完整且 Hash 一致。  
  * 若缺任一項 → **BLOCK\_RELEASE**，禁止進入 Pipeline B \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。

---

## 4.3 策略管線 (Pipeline B: StrategyPack)

本章節定義「策略管線 (Pipeline B)」的工程實作細節。此管線負責將抽象的「偽代碼規格 (SpecPack)」轉化為經過驗證的「可執行策略 (StrategyPack)」。依據《Spartoi-OMOC\_開發實作方案.md》，此階段必須嚴格執行「三源融合」與「過擬合防禦」，並產出可被稽核的證據包 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1[.4.0.md](http://.4.0.md)\]。  
---

#### **4.3.1 CA-METHOD (方法制定工作站)**

**核心職責**： CA-METHOD 是策略生成的工廠。它接收來自 CA-DSL 的原語定義，結合市場微結構與技術指標，產出版本化的 `method_card`。此工作站必須確保策略邏輯的完整性與合規性，嚴禁在此階段進行 XS 語法轉譯 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

* **三源融合機制 (Three-Source Fusion)**： 策略制定必須融合以下三個來源，缺一不可：

  * **Distillation (蒸餾)**：來自 Pipeline A 的 `distill_bundle`，提供核心交易邏輯 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
  * **Skill Library (技能庫)**：來自 `technique_registry.json` 的標準化 ICT 模組（如 FVG, OB, MSS） \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
  * **Market Profile (市場輪廓)**：來自 `market_profile.json` 的市場常數（如台股交易時段 09:00-13:30、漲跌幅限制）。**注意**：MethodCard 必須使用指標引用 Market Profile，嚴禁複製其內容以避免漂移 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **ICT 模組熱插拔 (Hot-Swap)**： 實作「雙鍵綁定 (Dual-Key Binding)」機制，確保策略模組可追溯且可替換：

  * **Slot Key**：流程槽位標識（如 `WEEKLY_BIAS`）。  
  * **MethodCard Key**：實際綁定的方法卡版本（如 `method_v1.2.0`）。  
  * **四路徑切換**：支援 Disabled (停用)、Replaced (替換)、Rollback (回滾)、A-B Test (對照驗證) \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
* **MVP 最小行為與 I/O**：

  * **Input**: `dsl_schema.json` (來自 CA-DSL) \+ `SpecPack` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **Output**: `/outputs/method_card.md` (或 .json) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **Verify**: 檢查必填欄位（輸入/輸出/前置/禁忌/風控/適用盤態）是否完整 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **Stopline**: 若規則自相矛盾或必填欄位缺失，立即 **STOP** 並進入人工裁決 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Gate 驗證**：

  * **MSC Gate (Method-Semantics Conformance)**：驗證方法卡是否符合 Schema、DbC 斷言是否通過、RTM 雙向覆蓋率是否達標 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
  * **Fail-Closed**: MSC 失敗則阻斷進入回測階段 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。

#### **4.3.2 CA-BACKTEST (回測驗證工作站)**

**核心職責**： CA-BACKTEST 負責對 `method_card` 進行歷史數據驗證。此階段不僅是跑回測，更是執行「過擬合防禦 (Overfitting Defense)」的關鍵關卡。未經此站驗證的策略，嚴禁進入選股或實盤階段 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

* **過擬合防禦體系 (Overfitting Defense Architecture)**： 必須依序執行以下四大防線，任一失敗即視為策略不可用：

  * **Walk-Forward Validation (移動窗驗證)**：嚴格區分訓練集與測試集，防止未來資訊洩漏 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
  * **PBO (Probability of Backtest Overfitting)**：計算回測過擬合機率，需在可接受範圍內 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
  * **CSCV (Combinatorial Symmetric Cross-Validation)**：執行組合交叉驗證，確保策略穩健性 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **DSR (Deflated Sharpe Ratio)**：校正多重比較後的夏普比率，報告必須包含此指標 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **MVP 最小行為與 I/O**：

  * **Input**: `method_card.md` \+ `market_data` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **Output**: `/outputs/backtest_report.json` \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **Verify**: 驗證 **BT-Repro** (資料 hash 一致性) 與回測衛生 (無前視/無洩漏/含成本) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **Stopline**:  
    * 若 BT-Repro 不可重現 → **STOP** (診斷資料污染) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
    * 若回測衛生失敗 → **STOP** \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
    * 若勝率 \< 40% → **RADAR\_ONLY** (標記風險但不阻斷，視為實驗性策略) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Gate 驗證**：

  * **G-BT-H (Backtest Health Gate)**：檢查回測報告是否存在、口徑是否一致、是否通過防前視檢查。若失敗則阻斷 StrategyPack 產出 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。

#### **4.3.3 StrategyPack 產出與交接**

**核心職責**： Pipeline B 的最終產物是 **StrategyPack**。這是連接「策略研發」與「執行部署」的契約包裹。

* **StrategyPack 內容**：

  * `method_card_v1.json` (策略定義)  
  * `backtest_report.json` (驗證報告)  
  * `risk_card.json` (風控參數) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **護欄 (Guardrails)**：

  * **禁止 XS 轉譯**：StrategyPack 僅包含邏輯描述，**嚴禁** 包含任何 XS/XQ 腳本代碼。轉譯工作必須由 Pipeline C (CA-TRANSLATE) 負責，以確保職責分離 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **禁止 UI 實作**：此包不含任何 UI 相關代碼 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Fail-Closed 交接**：

  * 透過 `manifest.json` 進行交接，必須包含所有輸入/輸出檔案的 Hash。  
  * 若 G-BT-H 或 MSC Gate 失敗，系統自動 **BLOCK** StrategyPack 的發布，防止瑕疵策略流入下游 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。

---

## **4.4 執行管線 (Pipeline C: XSPack)**

本管線負責將抽象的策略邏輯（MethodCard）與市場數據結合，產出具體的交易候選名單與執行腳本。此階段是連接「規劃」與「執行」的關鍵橋樑，必須嚴格執行 **SEM³ TVE (Translation-Validation Equivalence)** 驗證，確保轉譯後的腳本行為與原始策略意圖完全一致。  
---

### **4.4.1 CA-TA (技術分析工作站)**

CA-TA (Technical Analysis) 是執行管線的起點，負責對市場數據進行標準化的技術指標運算與市場狀態判定。

* **職責與定位**：

  * 位於 `core/analytics/` 目錄，作為技術分析引擎。  
  * 負責依據 **CA-METHOD** 產出的方法卡（MethodCard），產出日/周分析包（Technical Analysis Package），包含技術指標數值與趨勢判斷 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **輸入契約 (Inputs)**：

  * `method_card.md`：來自 Pipeline B 的定案策略 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * `market_data`：市場行情資料（需符合 Data Quality Gate 標準） \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **輸出契約 (Outputs)**：

  * `ta_pack.json`：包含已計算的技術指標、關鍵價位（Key Levels）與市場結構狀態（Market Structure） \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **最小行為 (MVP Minimum Behavior)**：

  * 執行指標運算邏輯。  
  * 驗證分析結果的準確度（Accuracy）是否達到最小門檻（如 \>= 40%） \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **Gate 綁定**：

  * **G-CONF-L (Confidence/Coverage Gate)**：驗證分析覆蓋率與信賴度 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Fail-Closed / Stopline (阻斷與降級)**：

  * **RADAR\_ONLY**：若準確度 \<= 40%，不阻斷流程但標記為高風險，供後續參考 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **STOP**：若樣本數不足，或分析結果與方法卡定義矛盾，立即停止並報錯 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **證據落點**：

  * `/evidence/ta/{run_id}/accuracy_report.json` \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

### **4.4.2 CA-SELECT (選股工作站)**

CA-SELECT (Stock Selection) 負責將技術分析結果轉化為具體的候選名單，執行漏斗式的篩選邏輯。

* **職責與定位**：

  * 位於 `core/analytics/` 目錄。  
  * 負責執行選股篩選（Filtering）、TopK 排序與候選名單管理。必須依據 `ta_pack` 與 `method_card` 的規則，產出 **S1 (Primary)** 與 **S2 (Secondary)** 候選清單 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **輸入契約 (Inputs)**：

  * `ta_pack.json`：來自 CA-TA 的分析結果。  
  * `method_card`：包含選股條件（如 EQA100 過濾規則） \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **輸出契約 (Outputs)**：

  * `select_results.json`：包含 S1/S2 候選股票代碼及其評分 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **最小行為 (MVP Minimum Behavior)**：

  * 執行選股邏輯，生成候選清單。  
  * 確保產出存在，且每檔候選股皆可追溯至 TA 分析結果與選股規則 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **Gate 綁定**：

  * **G-CONF-L**：驗證選股結果的信賴區間 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Fail-Closed / Stopline (阻斷與降級)**：

  * **Empty List \+ Record**：若選股失敗或無符合條件標的，產出空清單並記錄原因，視情況決定是否阻斷後續流程（如無標的則當日不交易） \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **證據落點**：

  * `/evidence/select/{run_id}/select_results.json` \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

### **4.4.3 CA-TRANSLATE (轉譯工作站)**

CA-TRANSLATE (Translation) 是執行管線的終點，負責將中立的策略邏輯「落地」為 XQ 全球贏家可執行的腳本。這是 **XQ 唯一下單端** 約束的前置關鍵步驟。

* **職責與定位**：

  * 位於 `trading/translate/` 目錄。  
  * 作為 XS/XQ 轉譯器，負責將中立的 DSL 或方法卡邏輯轉譯為 **XScript (XS)** 語法。此環節是 **SEM³ TVE (Translation-Validation Equivalence)** 的執行點，確保程式碼邏輯與策略語義等價 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
* **輸入契約 (Inputs)**：

  * `method_card_v1`：定案的策略邏輯。  
  * `select_results`：S1/S2 候選清單 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **輸出契約 (Outputs)**：

  * `xs_pack.zip`：包含以下核心檔案：  
    * `xs_script.txt`：可執行的 XS 腳本源碼。  
    * `watchlist.csv`：匯入 XQ 的觀察清單。  
    * `import_instructions.md`：匯入說明文件 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **工程限制與降級 (Constraints)**：

  * **No CLI Compiler**：由於 XQ 缺乏官方 CLI 編譯器，自動化流水線無法直接呼叫編譯器進行二進位驗證。  
  * **Fail-Closed**：必須採用「靜態語法檢查」或「人工/WT-NA 輔助驗證」作為替代方案。嚴禁依賴不穩定的非官方逆向工程手段 \[整合平面工具鏈與量化交易邏輯之自動化骨架：Spartoi-OMOC 方案 B 實作與規章驗證報告\]\[Spartoi-OMOC\_開發實作方案.md\]。  
* **最小行為 (MVP Minimum Behavior)**：

  * 將方法卡邏輯轉譯為 XS 語法。  
  * 打包生成 `xs_pack.zip`。  
  * 通過 `G-XQ-PARITY` 驗證（包含靜態語法檢查與訊號等價性測試） \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **Gate 綁定**：

  * **G-XQ-PARITY (XQ Consistency Gate)**：  
    * 檢核項目：XS 可編譯（Compile Status \= SUCCESS）、Signal Parity Score \>= 0.95（訊號一致性） \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **Fail-Closed / Stopline (阻斷與降級)**：

  * **BLOCK**：若編譯失敗（或靜態檢查未過），立即阻斷後續流程，禁止進入盯盤階段 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **Candidate Threshold**：若 TVE 分數未達標（如 \< 0.88，此為 Candidate 門檻），阻斷 XS 腳本上線 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **證據落點**：

  * `/evidence/translate/{run_id}/xs_pack.zip` \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

---

## **4.5 運行與治理 (Runtime & Governance)**

本區域包含 6 個關鍵 CA 子系統（CA-WATCH, CA-EXECUTE, CA-PERFORM, CA-GOVERN, CA-UI, CA-COLLAB）。依據 P1\_ARCH v6.0.0-r5 定義，此區域嚴格執行「決策隔離（Decision Isolation）」與「唯一下單端（Sole Order Endpoint）」原則，確保所有高風險操作皆受治理層（Control Plane）的物理限制。  
---

### **4.5.1 CA-WATCH (盯盤工作站)**

CA-WATCH 負責將 XS 轉譯後的腳本載入 XQ 全球贏家，並執行即時行情的監控與信號觸發。它是交易流程的「眼睛」，但被嚴格限制手腳，**絕對禁止執行下單動作**。

* **核心職責**：

  * **即時監控**：訂閱即時行情（Real-time Data），依據 `xs_watchlist` 中的條件進行掃描 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
  * **信號產生**：當市場條件滿足 ICT 模組邏輯（如 \#19 BOS/CHoCH, \#21 FVG）時，產生 `watch_signal.json` \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
  * **WatchScore 計算**：依據信號品質計算 WatchScore，供 HITL 決策參考 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **關鍵約束（Fail-Closed）**：

  * **Watch 不下單**：CA-WATCH 的輸出僅限於提醒、訊號與證跡。任何嘗試呼叫下單 API 的行為將觸發 Gate 阻斷 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
  * **訂閱斷線處理**：若即時行情中斷，必須自動重連；若無法重連，則標記狀態為 `DATA_LAG` 並暫停信號產生 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **I/O 契約**：

  * **Input**: `xs_script` (from CA-TRANSLATE), Real-time Data.  
  * **Output**: `watch_plan.json`, `watch_signal.json`, `watch_log.json`.  
  * **Gate**: 通過 `G-RUN` 確保監控服務正常啟動 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

### **4.5.2 CA-EXECUTE (操盤工作站)**

CA-EXECUTE 是系統中風險最高的組件，負責生成最終的交易指令。依據「XQ 唯一下單端」原則，其產出僅為「指令文件」，實際資金操作需經 HITL 確認後在 XQ 端執行。

* **核心職責**：

  * **指令生成**：接收經過 HITL 確認的 `hitl_handoff.json`，生成標準化的委託指令（Order Instructions）\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
  * **倉位管理**：維護 `position_ledger.json`，計算當前曝險與保證金使用率。  
  * **Kill Switch 執行**：監控 `kill_switch_signal`，一旦觸發（如虧損達標、系統異常），立即生成「一鍵全平（Close All）」指令 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **關鍵約束（Fail-Closed）**：

  * **XQ 唯一下單端**：本地代碼不直接對接券商 API，僅產出給 XQ 或操作員的指令。自動下單（XSAT）功能預設為 `DISABLED`，需經 CR\_OPEN-007 驗證後方可啟用 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **時序硬規則**：  
    * **13:10**：禁止新倉（含加碼）。  
    * **13:20**：強制清倉（T0 模式）。  
    * **13:25-13:30**：ROD-Only（禁止市價單）\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
  * **HITL 強制**：所有進場、加碼、清倉指令必須有對應的 `hitl_confirmed: true` 標記 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **I/O 契約**：

  * **Input**: `hitl_handoff.json` (Approved).  
  * **Output**: `execution_log.json`, `exec_report.json`.  
  * **Gate**: `G-HITL-LOG` 驗證 HITL 簽核紀錄 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

### **4.5.3 CA-PERFORM (績效工作站)**

CA-PERFORM 負責閉環反饋（Feedback Loop），通過雙跑道架構評估策略與系統的健康度。

* **核心職責**：

  * **Track-A 策略績效**：計算勝率、盈虧比（P/L Ratio）、風險調整後報酬（Risk-Adjusted Return）。支援 SRS-MEAS-001\~005 五項可量測目標 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **Track-B 工程可靠度**：計算系統 Uptime、資料完整性、Pipeline 成功率、驗證通過率 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **歸因分析**：將績效結果回饋至 CA-METHOD，觸發 MethodCard 版本迭代 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **關鍵約束**：

  * **資料一致性**：計算必須基於不可篡改的 `execution_log` 與 `market_data`，禁止使用未經核實的數據 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **I/O 契約**：

  * **Input**: `execute_record.json`, `trade_log`.  
  * **Output**: `perf_summary.json`, `performance_report.json`.

### **4.5.4 CA-GOVERN (治理工作站)**

CA-GOVERN 是控制平面（Control Plane）的邏輯實體，負責維護系統的「憲法」與「狀態」。在「方案 B」中，它通常體現為 GitHub Actions 的治理 Workflow 與儲存庫中的配置檔。

* **核心職責**：

  * **三件套管理**：維護 `flag_registry.json`（旗標）、`degrade_matrix.json`（降級）、`run_config_snapshot.json`（快照）的 SSOT 地位 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **Gate 執行**：調度 Validators 與 Evals Runner，執行各階段的 Gate Check 並產出 `gate_result.json` \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **Artifact Store**：管理所有產出工件的版本化存儲與索引 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **Orchestrator**：負責 SF-00 至 SF-17 的流程編排與狀態追蹤 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **關鍵約束（Fail-Closed）**：

  * **寫入權限獨佔**：只有 CA-GOVERN 有權限寫入 Flag Registry 與配置快照，其他子系統僅能讀取 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
  * **治理失敗即阻斷**：若治理檢查（如 SSOT 一致性）失敗，全系統進入 `BLOCK_RELEASE` \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。

### **4.5.5 CA-UI (入口工作站)**

CA-UI 是使用者的單一操作介面（Desktop App / CLI），連接所有子系統，但本身不包含業務邏輯。

* **核心職責**：

  * **操作入口**：提供 Dashboard 供使用者觸發 Pipeline、查看狀態與日誌 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **HITL 介面**：顯示待確認的 `hitl_handoff`，提供 Approve/Reject 按鈕，並將決策回寫至系統 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
  * **WT-NA 精靈**：輔助「人工複製貼上」協作流程，生成提示詞並接收 LLM 回應 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **Automation Assistant**：整合 Playwright 執行輕量級瀏覽器自動化任務 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **關鍵約束**：

  * **決策隔離 (Decision Isolation)**：UI 僅負責「展示（Display）」與「傳遞（Relay）」，嚴禁在 UI 層實作交易策略或風控邏輯 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。

### **4.5.6 CA-COLLAB (協作工作站)**

CA-COLLAB 負責管理多 LLM 協作與 Agent 模式，是 AI 介入系統的管控中心。

* **核心職責**：

  * **Agent 雙模管理**：控制系統處於 `NON_AGENT`（純手動）或 `AGENT_ASSIST`（AI 輔助）模式 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
  * **AES (Agent Extension Slot)**：提供標準化的 Agent 能力擴充插槽 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **Policy Enforcement**：執行 AgentPolicy、ToolPolicy 與 ApprovalPolicy，確保 Agent 行為合規 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **輸入淨化**：執行 Input Trust Tier 檢查，對 L3（Untrusted）輸入進行拒收或淨化 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
* **關鍵約束**：

  * **No-Paid-LLM-API**：確保協作流程不依賴付費 API，優先使用本地模型或免費層級 \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
  * **異常降級**：若 Agent 行為異常或預算超支，強制切換回 `NON_AGENT` 模式 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。

---

# 5\. 自動化流水線與任務編排 (Pipeline & Orchestration)

本章節定義如何將 Spartoi 的業務邏輯（15 CA 子系統）轉化為可由 OMOC 執行的自動化流水線。依據「方案 B」戰略，我們不自研 Pipeline DSL，而是採用 **GitHub Matrix** 與 **CA\_ID 參數化** 技術，配合 **SF 主鍵體系** 與 **JobCard 架構**，實現單一流水線對多工作站的統一調度。

---

## 5.1 核心流程 (SF Keyspace)

**SF 主鍵體系 (Spartoi Flow Keyspace)** 是系統中唯一合法的流程索引機制。在「OMOC-GMA Lite」架構下，SF 主鍵不僅是文件章節編號，更是自動化流水線中 `matrix.ca_id` 的核心參數與 `run_config_snapshot` 的狀態錨點。  
---

#### **5.1.1 SF 主鍵體系 (SF Keyspace System)**

依據《Spartoi｜P1\_台股當沖隔日沖流程\_執行手冊\_v2.1.0》與《P1\_LBP-A(SIR)》定義，系統強制使用 **SF-00** 至 **SF-31** 作為全域唯一主鍵，嚴禁使用舊版 Token。

**A. 主鍵定義與範圍**

* **唯一性 (Uniqueness)**：每個 SF 節點擁有唯一主鍵，不可重複使用。  
* **槽位總量**：共定義 32 個槽位（SF-00 \~ SF-31）。  
  * **活躍槽位 (Active Slots)**：18 個（SF-00 \~ SF-17）。  
  * **保留槽位 (Reserved Slots)**：14 個（SF-18 \~ SF-31）。  
* **綁定關係**：主鍵與子系統職責強綁定，作為 JobCard 的索引鍵。

**B. 核心節點清單 (SF Node Index)** 下表為 SF 主鍵與子系統及職責的標準映射，此為自動化調度（Orchestrator）的路由表：

| SF ID | Domain ID | 節點名稱 | 負責子系統 (CA) | 核心職責 (Core Responsibility) | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **SF-00** | SF-G00 | **Preflight / Evidence Gate** | CA-GOVERN | 執行日開始前的證據門檢查、環境指紋驗證。 |  |
| **SF-01** | SF-K01 | **教材蒐集 (WRC)** | CA-WRC | 白名單教材入庫、週級審視與策展。 |  |
| **SF-02** | SF-K02 | **語料庫構建 (Corpus)** | CA-CORPUS | 語料分塊、索引建立、教材庫建構。 |  |
| **SF-03** | SF-K03 | **蒸餾 (Distill)** | CA-DISTILL | LLM 蒸餾、SEM³ 三層蒸餾執行。 |  |
| **SF-04** | SF-K04 | **IR 生成 (DSL)** | CA-DSL | 中立 DSL 原語定義、中間表示生成。 |  |
| **SF-05** | SF-K05 | **方法制定 (Method)** | CA-METHOD | 方法卡 (MethodCard) 生成、MarketProfile 綁定。 |  |
| **SF-06** | SF-K06 | **回測 (Backtest)** | CA-BACKTEST | Walk-Forward 驗證、過擬合防線執行。 |  |
| **SF-07** | SF-K07 | **技術分析 (TA)** | CA-TA | 產出技術指標、TA 分析包。 |  |
| **SF-08** | SF-T08 | **選股 (Select)** | CA-SELECT | 執行選股邏輯、TopK 候選產出。 |  |
| **SF-09** | SF-T09 | **轉譯 (Translate)** | CA-TRANSLATE | XS/XQ 語法轉譯、TVE Gate 驗證。 |  |
| **SF-10** | SF-T10 | **盯盤 (Watch)** | CA-WATCH | 訊號監控、入場提醒（**不下單**）。 |  |
| **SF-11** | SF-T11 | **HITL 決策門 (Decision Gate)** | **HITL (Gate)** | 人工決策確認點。**SF-11 是 Gate，不是子系統**。 |  |
| **SF-12** | SF-T12 | **執行 (Execute)** | CA-EXECUTE | 執行下單、硬規則落地（**需經 SF-11 確認**）。 |  |
| **SF-13** | SF-T13 | **績效分析 (Perform)** | CA-PERFORM | 績效評估、雙跑道分析。 |  |
| **SF-14** | SF-G14 | **Kill Switch** | CA-GOVERN | 緊急停機處置。 |  |
| **SF-15** | SF-G15 | **Drift Detection** | CA-GOVERN | 漂移偵測。 |  |
| **SF-16** | SF-G16 | **ROD-Guard** | CA-GOVERN | ROD-only 委託守衛（13:25-13:30）。 |  |
| **SF-17** | SF-G17 | **Artifact Sync** | CA-GOVERN | 產物同步與歸檔。 |  |
| **SF-31** | \- | **績效/版本化** | CA-PERFORM | 全域版本化管理與可回溯性。 |  |

**C. Legacy Token 處置 (Fail-Closed)** 為了確保自動化腳本的解析一致性，系統實施嚴格的 Token 淨化政策：

* **正文禁用**：SRS、ARCH、Runbook 正文中嚴禁出現舊主鍵（如 `DayFlow`, `DF-xx`, `ICT-xx`, `Stage-xx`）。  
* **唯一允許區**：舊主鍵僅允許出現在 `APPX-A Crosswalk` 附錄中，作為對照轉接使用。  
* **檢核規則**：CI 流程中的 `Scope-Violation Scanner` 會掃描正文，若發現 Legacy Token 則視為 **FAIL**，阻斷發布。

---

#### **5.1.2 JobCard 架構 (JobCard Architecture)**

**JobCard** 是 Spartoi Flow 中單一任務的標準化執行契約。依據「方案 B」，JobCard 是連接 OMOC 執行平面與 GitHub 控制平面的核心資料結構。每個 SF 節點在執行時，**MUST** 產生對應的 JobCard 實例。

**A. 結構定義 (9 欄位標準)** 符合 SRS §3.3 (SRS-FR-JOBCARD-001) 要求，每個 JobCard 必須包含以下 9 個核心欄位：

1. **job\_id**: 唯一識別碼 (UUID)，用於全域追蹤。  
2. **sf\_ref**: 對應的 SF 節點編號 (SF-00 \~ SF-31)，確保流程對位。  
3. **inputs**: 輸入檔案清單、格式與 Schema 引用。  
4. **preconditions**: 環境狀態、資料庫狀態、模式前置條件（如 `trading_mode`）。  
5. **commands**: 最小化的 CLI 指令或腳本調用序列。  
6. **acceptance**: 產物檢核規則與通過條件（如 `verification_method`）。  
7. **logs**: 必要日誌欄位定義與事件類型。  
8. **rollback**: 回滾策略（REVERT / COMPENSATE / MANUAL）與具體步驟。  
9. **kill\_switch**: 緊急停止的觸發條件與處理動作。

**B. 複合鍵綁定 (Composite Key Binding)** 為了防止 Stage ID 漂移並確保 JobCard 與 SF 節點的唯一對應，系統採用 **複合鍵 (Composite Key)** 機制：

* **格式**：`{sf_ref}@{domain_id}`  
* **Domain ID 格式**：`SF-[K|T|G]xx`  
  * `K`: Knowledge (知識鏈)  
  * `T`: Trading (交易鏈)  
  * `G`: Governance (治理鏈)  
* **範例**：`SF-12@SF-T12`（SF-12 屬於交易鏈 T）。  
* **約束**：不得混用 Domain，若格式錯誤則 **FAIL**。

**C. 生命週期與狀態機 (Lifecycle & State Machine)** JobCard 的執行遵循嚴格的狀態機邏輯，由 **Orchestrator** 負責管理：

* **狀態流轉**：`PENDING` → `RUNNING` → `COMPLETED` 或 `FAILED`。  
* **事件產生**：每個狀態轉換 **MUST** 產生對應的 `event_log`。  
* **Fail-Closed 行為**：  
  * **INVALID/BLOCKED**：若 JobCard 驗證失敗或被 Gate 阻斷，不得進入執行狀態。  
  * **FAILED**：若執行失敗，自動觸發 `rollback` 策略（除非策略為 MANUAL）。  
  * **TIMEOUT**：若執行超時，強制終止並觸發 `KILL-2` 級別熔斷。

**D. 模板與實例化 (Template & Instantiation)**

* **JobCard Template**：每個 SF 節點在 Registry 中有唯一的模板定義（如 `JC-PREFLIGHT` 對應 SF-00）。  
* **JobCard Instance**：運行時根據模板與當前 Context（如 run\_id）實例化，並寫入 **Artifact Store** 作為證據。

**E. 失敗處理與回滾 (Failure Handling & Rollback)** 依據，JobCard 必須定義明確的失敗處理策略：

* **VALIDATION\_FAILED**：Schema 驗證失敗 → 拒絕執行 → 阻斷流程。  
* **PRECOND\_FAILED**：前置條件未滿足 → 依配置決定等待、跳過或轉手動。  
* **EXECUTION\_FAILED**：執行過程異常 → 自動執行 Rollback。  
* **Rollback 策略**：  
  * `REVERT`：還原至執行前狀態（適用於資料變更可逆）。  
  * `COMPENSATE`：執行補償動作（適用於不可逆變更）。  
  * `MANUAL`：產生人工介入請求（適用於高風險操作）。

---

#### **5.1.3 專線化輸入適配 (Specialized Input Adapters)**

針對非結構化輸入（如 PDF 教材、非結構化文字），方案 B 要求在 SF-01 (WRC) 與 SF-03 (Distill) 階段引入專用適配器，將其轉化為 JobCard 可消費的標準輸入。

* **Docling 整合**：利用 Docling 工具將 PDF/掃描檔轉換為 Markdown 或結構化 JSON。  
* **Input Sanitization**：依據 `Input Trust Tier` 政策，對所有外部輸入進行淨化（Sanitizer），標記為 L0-L3 信任等級。L3 (Untrusted) 輸入必須經過處理才能進入 Pipeline。  
* **Fail-Closed**：若適配轉換失敗或信任等級不足，JobCard 必須拒絕執行並回報 FAIL。

---

## 5.2 三管線協作 (Pipeline A/B/C)

本章節詳述如何利用 **OMOC 的執行能力** 與 **GitHub Actions 的矩陣調度（Scheme B）**，將 Spartoi 的 15 個子系統串聯為三條互不重疊、單向依賴的自動化生產管線（Pipelines）。依據「開發實作方案」的定義，我們不建立複雜的 DAG 排程平台，而是利用 **GitHub Reusable Workflows** 搭配 **CA\_ID 參數化** 來實現標準化的「輸入 $\\to$ 處理 $\\to$ 證據 $\\to$ 輸出」閉環。  
---

#### **5.2.1 Pipeline A: SpecPack (知識管線)**

**核心職責**：將非結構化的 ICT 教材轉化為結構化的偽代碼與原語規格，建立系統的「知識基底」。此管線由「媽媽」角色負責，產出不可變的規格包（SpecPack）。

* **執行順序 (Stage Sequence)**：

  * **SF-01 CA-WRC** (教材蒐集) $\\to$  
  * **SF-02 CA-CORPUS** (語料庫) $\\to$  
  * **SF-03 CA-DISTILL** (蒸餾) $\\to$  
  * **SF-04 CA-DSL** (原語庫) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
* **輸入與配置 (Inputs)**：

  * **ICT\_PDF\_POINTERS**：白名單教材 PDF 路徑清單。  
  * **corpus\_config.yaml**：定義分塊與索引策略。  
  * **Trigger**：每週五盤後或手動觸發 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **輸出產物 (Artifacts: SpecPack)**：

  * 路徑：`SpecPack/<specpack_id>/`  
  * 內容包含：  
    * `input_manifest.json`：原始教材的雜湊指紋。  
    * `corpus_snapshot.json`：語料庫快照索引。  
    * `distill_bundle.json`：蒸餾後的知識單元。  
    * `dsl_schema.json`：中立的 DSL 原語定義 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。  
* **Gate 綁定與護欄 (Gates & Guardrails)**：

  * **G-SRC (來源完整性)**：驗證所有輸入教材均在白名單內，且 Provenance 完整 \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
  * **G-SEG-L (語意保真)**：驗證蒸餾產物與原教材的語意一致性，需通過 Golden Set 抽樣 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **G-SCHEMA (結構完整性)**：驗證 DSL Schema 符合定義 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **護欄 (Constraints)**：本管線 **禁止實作** (No Implementation)、**禁止回測** (No Backtest)、**禁止 XS 轉譯** \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **自動化實作 (Scheme B)**：

  * 調用 `orchestrate --pipeline A`，透過 GitHub Matrix 並行處理多份教材的蒸餾，最後由 `CA-DSL` 進行 Reduce 整合 \[Spartoi-OMOC\_開發實作方案.md\]。

#### **5.2.2 Pipeline B: StrategyPack (策略管線)**

**核心職責**：基於 SpecPack 定義的知識，組裝策略邏輯並進行回測驗證。此管線由「弟弟」角色負責，產出可執行的策略包（StrategyPack）。

* **執行順序 (Stage Sequence)**：

  * **SF-05 CA-METHOD** (方法制定) $\\to$  
  * **SF-06 CA-BACKTEST** (回測驗證) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **輸入與配置 (Inputs)**：

  * **SpecPack**：必須引用 Pipeline A 產出的固定版本（Version Pinning）\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
  * **market\_data\_pointer**：回測用的歷史數據源。  
* **輸出產物 (Artifacts: StrategyPack)**：

  * 路徑：`StrategyPack/<strategypack_id>/`  
  * 內容包含：  
    * `method_card_v1.json`：策略邏輯卡，含進出場規則與風控參數。  
    * `backtest_report.json`：回測績效報告（含 PBO/Sharpe/Drawdown）。  
    * `risk_card.yaml`：風險極限定義 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
* **Gate 綁定與護欄 (Gates & Guardrails)**：

  * **G-BT-H (回測健康度)**：驗證回測無前視偏差 (Look-ahead Bias)，且統計顯著 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **G-SRC (來源完整性)**：確保引用了正確版本的 SpecPack \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。  
  * **護欄 (Constraints)**：本管線 **禁止 XS 轉譯**、**禁止 UI 實作** \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **B-Learn 子管線 (反饋迴圈)**：

  * 負責 **CA-PERFORM** 與 **FEEDBACK**，產出 `FeedbackPack`。  
  * **規則**：FeedbackPack 僅允許輸出「提案 (Proposal)」，**不允許直接修改 MethodCard**。策略變更必須重新觸發 Pipeline B-Strategy 進行完整回測 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

#### **5.2.3 Pipeline C: XSPack (執行管線)**

**核心職責**：將通過驗證的策略轉譯為 XQ 平台可執行的 XS 腳本，並生成選股清單。此管線由「爸爸」角色負責，產出執行包（XSPack）。

* **執行順序 (Stage Sequence)**：

  * **SF-07 CA-TA** (技術分析) $\\to$  
  * **SF-08 CA-SELECT** (選股) $\\to$  
  * **SF-09 CA-TRANSLATE** (轉譯) \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **輸入與配置 (Inputs)**：

  * **SpecPack \+ StrategyPack**：必須引用前兩條管線的固定版本。  
  * **258 母池**：候選股票清單 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **輸出產物 (Artifacts: XSPack)**：

  * 路徑：`XSPack/<xspack_id>/`  
  * 內容包含：  
    * `xs_script.txt`：可匯入 XQ 的腳本代碼。  
    * `xs_script_pack.json`：腳本元數據。  
    * `watchlist.csv`：監控標的清單。  
    * `import_instructions.md`：匯入 XQ 的操作指引 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **Gate 綁定與護欄 (Gates & Guardrails)**：

  * **G-CONF-L (信賴度)**：驗證選股清單符合策略邏輯 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **G-XQ-PARITY (XQ一致性)**：驗證 XS 腳本的邏輯與 MethodCard 的邏輯等價 (TVE 驗證)，且可編譯通過 \[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]。  
  * **G-HITL-LOG (HITL日誌)**：確保包含人工確認的檢查點 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
  * **護欄 (Constraints)**：本管線 **禁止修改方法卡**、**禁止修改回測參數**。**XQ 為唯一下單端**，本地僅產生指令 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

#### **5.2.4 自動化路由實作 (Scheme B Implementation)**

本節定義如何利用 GitHub Actions 與 OMOC 實現上述三管線的自動調度，遵循「方案 B」的單一流水線原則。

* **單一入口 (Orchestrator CLI)**：

  * 使用 `orchestrate` 指令作為統一入口，接受參數：`--pipeline {A|B|C}`、`--run_id`、`--mode {dev|ops}` \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。  
  * 範例：`./scripts/entrypoint.sh --job-spec jobs/pipeline_a.job.yaml` \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* **參數化執行 (Matrix Execution)**：

  * 利用 GitHub Actions 的 `strategy.matrix`，將 15 個 CA 子系統視為可參數化的工作站。  
  * Workflow 定義中，透過 `workflow_call` 傳遞 `CA_ID`，動態載入對應的 `station.config.yaml` \[Spartoi-OMOC\_開發實作方案.md\]。  
* **可重用工作流 (Reusable Workflows)**：

  * 建立 `.github/workflows/_reusable_ca.yml`，封裝通用的 Setup、OMOC Init、Evidence Collect、Gate Check 步驟。  
  * 所有 Pipeline A/B/C 的 Stage 均調用此同一 Workflow，僅輸入參數不同，最大化代碼重用 \[Spartoi-OMOC\_開發實作方案.md\]。  
* **文檔 Delta 回填 (Doc Delta)**：

  * Pipeline 執行結束後，自動產出 `SSOT.patch.md`。例如 Pipeline A 完成後，產出更新後的 `P1_LBP-A(SIR).md` 的更新建議，經 HITL 確認後合併，實現「跑一次就補一點」的文檔生長 \[Spartoi-OMOC\_開發實作方案.md\]。  
* **Fail-Closed 機制**：

  * 任何 Pipeline 執行過程中，若遇到 Gate 失敗、Evidence 缺失或 Schema 驗證錯誤，系統必須立即 **BLOCK\_RELEASE**（阻斷發布）或 **STOP**（停止流程），不得繼續執行下游任務 \[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

---

## **5.3 自動化執行 (Automated Execution)**

本章節依據《Spartoi-OMOC\_開發實作方案.md》確立的「方案 B」戰略，詳述如何透過「單一流水線（Single Pipeline）」與「參數化（Parameterization）」實現 15 個 CA 子系統的自動化調度。核心目標是在不自研複雜平台的前提下，利用現成工具鏈（GitHub Actions, OpenCode CLI）達成「最短工期、最低人工」的執行閉環。  
---

### **5.3.1 Orchestrator：單一流水線入口 (Single Pipeline Entrypoint)**

依據架構定義，Orchestrator（編排器）並非一個龐大的服務平台，而是一個位於 CA-GOVERN 轄下的獨立架構構件，負責將人類意圖轉化為可執行的 CLI 指令。

1. **實作形式：CLI 驅動**

   * Orchestrator 被實作為一個標準化的 CLI 入口腳本，通常位於 `./scripts/entrypoint.sh`。  
   * 該入口腳本必須支援透過 `--job-spec` 參數接收任務定義（Job Spec），並根據 `--profile`（dev 或 ops）切換執行情境。  
   * 若 Orchestrator 尚未完全落地，系統必須支援回退（Fallback）至 MinImpl 入口（`mvp_spine_v0_minimpl/executable_pack/entrypoint.sh`）以確保最小閉環的可執行性。  
2. **角色與職責**

   * **流程啟動**：負責觸發 SF-00 到 SF-17 的流程控制，並確保滿足前置條件（Preconditions）。  
   * **JobCard 處理**：Orchestrator 負責實例化 JobCard，將其與 SF 節點綁定，並追蹤其生命週期狀態。  
   * **無 API 依賴（No-LLM-API）**：Orchestrator 本身必須是「純規則驅動（Rule-driven）」，不依賴 LLM API 進行邏輯判斷，以確保在離線或 API 故障時仍能維持基礎運作。  
3. **OpenCode 整合**

   * 在執行層面，Orchestrator 透過 `opencode run` 指令或 `-p`（prompt）參數調用 OpenCode Agent。  
   * 在 CI 環境中，必須設定 `OPENCODE_DISABLE_AUTOUPDATE=true` 與 `--print-logs` 以確保執行的穩定性與可觀測性。

### **5.3.2 參數化執行：方案 B 的矩陣策略 (Parameterized Execution via Matrix)**

為了避免為 15 個子系統維護 15 套重複的 Workflow，本架構採用「方案 B」的核心技術：**GitHub Actions Matrix \+ Reusable Workflows**。

1. **矩陣執行模型 (Matrix Execution Model)**  
       \*   系統定義一個單一的主流水線設定檔（如 \`pipeline.yml\`），利用 \`strategy.matrix\` 動態生成針對不同 CA 子系統的執行作業。  
       \*   \*\*資源限流 (Throttling)\*\*：由於 GitHub Free 方案併發上限為 20 \[3\]\[9\]，為避免 15 個 CA 同時展開導致 CI 阻塞，\*\*必須\*\* 設定 \`max-parallel\`。  
     
   \`\`\`yaml  
   jobs:  
     ca-station-runner:  
       strategy:  
         fail-fast: false  \# 讓其他 CA 繼續跑完，便於一次收集所有錯誤  
         max-parallel: 5   \# \[Best Practice\] 限制同時運行 5 個 CA，防止塞爆隊列  
         matrix:  
           ca\_id: \[CA-WRC, CA-CORPUS, CA-DISTILL, ..., CA-GOVERN\]  
       uses: ./.github/workflows/\_reusable\_ca.yml  
       with:  
         ca\_id: ${{ matrix.ca\_id }}

2. **重用工作流 (Reusable Workflows)**

   * 核心邏輯封裝於 `_reusable_ca.yml`（`on: workflow_call`）。此工作流負責標準化的環境設置（Setup）、快取（Cache）、執行（Execute）與產物上傳（Upload Artifacts）。  
   * **Composite Actions**：將重複性的步驟（如安裝 OpenCode、執行 GateRunner）進一步封裝為 Composite Actions，以降低維護成本並確保執行的一致性。  
3. **輸入/輸出契約 (I/O Contracts)**

   * 在參數化執行架構下，每個 CA 工作站必須遵守統一的 I/O 格式：  
     * **Inputs Manifest**：定義本次執行的輸入資料版本與參數。  
     * **Evidence Manifest**：列出產出的證據與日誌。  
     * **Verdict**：明確的 PASS/FAIL 判定結果，供 GateRunner 讀取。  
   * **禁止特化**：嚴禁為特定 CA 建立完全不同的輸入輸出格式，這會破壞參數化執行的可重用性，導致「造輪子」風險。  
4. **併發控制 (Concurrency Control)**

   * 針對同一個 `ca_id` 必須設定 concurrency group，防止多個 Agent 同時寫入同一子系統導致的競態條件或資源衝突。

### **5.3.3 文檔 Delta 回填：SSOT 的自動演進 (Document Delta Write-back)**

在 Spartoi-OMOC 架構中，SSOT（單一真相來源）的更新不是開發的前置作業，而是自動化流水線的「副產物（Byproduct）」。

1. **流水線驅動的文檔更新**

   * 當流水線執行完成後，系統應自動產出針對 SRS、ARCH 或 Runbook 的增量變更（Delta），例如 `SRS.patch.md` 或 `ARCH.patch.md`。  
   * **自動產出建議**：Agent（如 Spec Lane Agent）依據執行結果生成文檔變更建議，而非由人類手動維護文檔的一致性。  
2. **變更審核與合併**

   * 產出的 Delta 文件不直接寫入 SSOT，而是透過 Pull Request (PR) 提交。  
   * **Required Checks**：利用 GitHub Rulesets 強制執行檢查（如 Link Check, Format Check），只有在所有檢查通過後，Delta 才能被合併回主幹。  
3. **失敗資產化 (Failure as Asset)**

   * 若執行失敗，流水線應觸發「錯題本（Wrongbook）」機制，將失敗案例與修復建議回填至 `WRONGB00K.md`，實現「複利工程」效應。

### **5.3.4 執行邊界與限制 (Execution Boundaries & Constraints)**

自動化執行必須在嚴格的邊界內運作，以符合 Spartoi 的治理規範與風險控制要求。

1. **XQ 唯一下單端 (XQ Sole Order Endpoint)**

   * **硬性約束**：本地自動化系統（OpenCode/OMOC）**僅允許**產生指令文件（Instructions）、訊號（Signals）與證據（Evidence）。  
   * **禁止自動交易**：實際的下單與成交動作 **必須且只能** 在「XQ 全球贏家」桌面程式端完成。任何試圖繞過此限制的自動化邏輯（如直接呼叫券商 API 下單）皆視為違規，觸發 Fail-Closed 阻斷。  
2. **Fail-Closed 預設行為**

   * 在任何自動化步驟中，若遇到資訊不足、驗證失敗、證據缺失或依賴服務不可用（如 API 當機），系統必須立即停止並回報失敗（BLOCK\_RELEASE），不得嘗試「猜測」或「略過」。  
3. **No-Paid-LLM-API 主路徑**

   * 核心自動化流程（Orchestrator）必須設計為在無付費 LLM API 的環境下亦可運作（降級模式）。LLM 僅作為「可選加速器」，而非「必要依賴」。  
   * 若偵測到強依賴付費 API 才能運行的情況，Gate 將阻斷發布。  
4. **Attended Mode 優先**

   * Orchestrator 預設運行於「有人值守（Attended）」模式。對於關鍵決策節點（尤其是涉及資金或破壞性操作），必須暫停並等待人類確認（HITL），禁止無人值守的全自動執行。

---

# 6\. 交易領域邏輯與時序 (Trading Domain & Timeline)

本章節定義 Spartoi 系統中不可協商的領域邏輯與時間邊界。依據「方案 B」的自動化骨架設計，這些規則並非僅由人工記憶，而是被轉化為 **控制平面 (Control Plane)** 中的 **硬狀態機 (Hard State Machine)** 規則。所有的時間窗檢核（Check）與阻斷（Block）邏輯，均須在 **CA-WATCH** 與 **CA-EXECUTE** 子系統中實施 Fail-Closed（預設阻斷）機制，並由 **CA-GOVERN** 進行治理監控。  
---

## 6.1 時序硬規則 (Invariants)

本節定義的三大時序不變量（INV-TIME-\*）是系統安全運行的物理底線。這些規則直接映射至架構層的「時間窗約束表（Time Window Constraints Table）」，並在執行層（Runbook）中作為最高優先級的檢查點。  
---

#### **6.1.1 INV-TIME-001：13:10 禁新倉 (No New Positions)**

此規則確立了 T0 當沖模式下的「最後進場時刻」，旨在確保所有當沖部位有足夠的時間進行去化或處理，避免尾盤流動性風險。

* **規則定義**：

  * **截止時間**：每日 **13:10:00**（以交易所撮合時間為準）。  
  * **禁止行為**：禁止建立任何新的 T0 當沖倉位（New Positions）。此限制包含「加碼（Scale-in）」與「新單（Open）」操作。  
  * **適用範圍**：  
    * **T0\_DAYTRADE 模式**：**強制執行**。所有標記為 T0 的策略在 13:10 後只能執行平倉（Close/Reduce）操作。  
    * **T1\_SWING 模式**：**不適用**（依據 T1 專屬規則處理）。  
* **Fail-Closed 阻斷機制**：

  * **執行點**：**CA-EXECUTE** 子系統內的 `Time Window Validator`。  
  * **阻斷行為**：若系統時間 $\\ge$ 13:10，且收到 `Open` 或 `Scale-in` 類型的委託指令，系統必須直接拒絕（Reject）該請求，不送往 XQ 下單端，並回傳 `FAIL` 狀態。  
  * **事件日誌**：必須產生事件 `inv_t0_newpos_blocked` 寫入控制平面日誌。  
* **例外處理**：

  * 僅允許「平倉（Close）」或「減碼（Scale-out）」指令通過。

**來源追溯**：

* 架構層對應：ARCH v6.0.0-r5 §8.4 `INV-T0-NEWPOS-CUTOFF`。  
* 執行層對應：Runbook v2.0.0 §3.1 `INV-TIME-001`。  
* 衝突裁決：依據 CL-001，確認包含「加碼」亦被禁止。

#### **6.1.2 INV-TIME-002：13:20 強制清倉 (Force Close T0)**

此規則是 T0 當沖模式的「最終防線」，強制確保當日部位不過夜，以符合當沖交易的定義與風險控制要求。

* **規則定義**：

  * **觸發時間**：每日 **13:20:00**。  
  * **強制行為**：系統必須檢查所有 T0 帳戶的剩餘庫存。若庫存 $\\neq$ 0，必須立即觸發強制平倉程序。  
  * **執行方式**：發送市價單（Market Order）或漲跌停價單進行全額平倉。  
* **Fail-Closed 與熔斷機制**：

  * **監控點**：**CA-EXECUTE** 子系統。  
  * **KS-003 強清失敗熔斷**：若在 13:20 發出強平指令後，至 13:22 仍未成交或庫存仍未歸零，系統必須觸發 **Kill Switch (KS-003)**。  
  * **緊急處置**：觸發 KS-003 後，系統進入 `EMERGENCY_STOP` 狀態，並透過 CA-UI 發出最高級別告警，要求人工（HITL）立即介入處理。  
  * **事件日誌**：必須產生事件 `inv_t0_force_close`。  
* **未成交處置流程**：

  * 依據 Patch-MAJ-005，若 13:20 強清未成交，需進入特定處置流程（如盤後定價交易或改掛 ROD 參與收盤競價）。

**來源追溯**：

* 架構層對應：ARCH v6.0.0-r5 §8.4 `INV-T0-FORCE-CLOSE`。  
* 執行層對應：Runbook v2.0.0 §3.2 `INV-TIME-002`。  
* 風險防線：對應 KS-003。

#### **6.1.3 INV-TIME-003：13:25-13:30 ROD-Only**

此規則針對台股收盤前 5 分鐘的「集合競價（Closing Auction）」時段，確保委託單符合交易所撮合規則，防止因訂單類型錯誤導致無法成交。

* **規則定義**：

  * **時間區間**：每日 **13:25:00 至 13:30:00**。  
  * **限制行為**：此時段進入「試搓」與「集合競價」階段，交易所僅接受 **ROD (Rest of Day)** 類型的限價單。  
  * **禁止項目**：  
    * 嚴禁使用 **IOC (Immediate or Cancel)** 或 **FOK (Fill or Kill)** 委託單。  
    * 嚴禁使用 **市價單 (Market Order)**。  
  * **影響範圍**：所有 T0 與 T1 模式的委託單（含補救用的平倉單）。  
* **Fail-Closed 阻斷機制**：

  * **檢核點**：**CA-EXECUTE** 內的 `Order Type Validator`。  
  * **阻斷行為**：若時間在 13:25\~13:30 之間，且偵測到非 ROD 的委託屬性，系統必須在本地直接拒絕（Reject）該指令，不送往 XQ。  
  * **事件日誌**：必須產生事件 `inv_rod_only`。  
* **操作指引**：

  * 若在此階段需要平倉，必須掛入 ROD 限價單（通常掛漲停價買進或跌停價賣出以確保成交，但屬性必須是 ROD）。

**來源追溯**：

* 架構層對應：ARCH v6.0.0-r5 §8.4 `INV-TWSE-ROD-ONLY`。  
* 執行層對應：Runbook v2.0.0 §3.3 `INV-TIME-003`。  
* 衝突裁決：依據 CL-RW-006，確立起始時間為 13:25 而非 13:20。

---

## **6.2 雙模運行 (T0/T1 Dual Mode Operation)**

本章節定義 Spartoi 系統中並行運作的兩套交易模式：**T0 當沖 (T0\_DAYTRADE)** 與 **T1 隔日沖 (T1\_SWING)**。依據《Spartoi-OMOC\_開發實作方案.md》確立的「方案 B」戰略，這兩種模式並非透過建立兩套獨立系統來實現，而是利用單一流水線（Single Pipeline）結合 GitHub Matrix 參數化執行與產物隔離機制來達成,。  
---

### **6.2.1 T0 當沖模式 (T0\_DAYTRADE)**

**定義與預設行為** T0\_DAYTRADE 是系統的預設基線模式（Default Baseline）。其核心定義為「當日進出，收盤前必須清倉」，嚴禁持有隔夜部位,。

* **操作方向**：允許 **做多 (Long)** 與 **做空 (Short)**。  
* **正打/反打定義**：在 T0 模式下，反打（Alternative Scenario）可為反向操作（如正打做多，反打做空），但倉位僅能使用正打的 50%。  
* **時序硬規則 (Hard Invariants)**：  
  * **INV-TIME-002 (13:20 強制清倉)**：若至 13:20 仍有未平倉部位，CA-EXECUTE 必須觸發強制市價平倉邏輯，確保 T0 屬性不被破壞,,。  
  * **INV-TIME-003 (ROD-Only)**：13:25 至 13:30 進入收盤集合競價，僅允許 ROD (Rest of Day) 委託，禁止市價單與新開倉,,。

**失敗處置 (Fail-Closed)** 若系統偵測到 T0 模式下有殘留部位跨越 13:30 收盤線，必須觸發 **KS-RECONCILE-HALT** (Kill Switch)，暫停次日交易並進入人工審查。

### **6.2.2 T1 隔日沖模式 (T1\_SWING)**

**定義與啟用條件** T1\_SWING 是系統的副線模式，允許持倉過夜，目標是捕捉波段利潤。此模式預設為關閉，必須透過旗標 `enable_t1_mode = true` 顯式啟用。

* **操作方向 (Strict Long Only)**：**嚴格限制只做多 (Long Only)**。  
  * **禁止做空**：在 T1 模式下，「反打」絕非「做空」，而是指「折返/回補後的做多」機會,。此為不可協商的業務紅線。  
* **專屬工件 (Artifacts)**：  
  * 啟用 T1 模式後，CA-METHOD 必須產出 **MethodCard\_T1** 與 **RiskCard\_T1**,。  
  * 必須維護 **OvernightPositionLedger** (隔夜持倉帳本) 與 **NextDayExitPlan** (次日出場計畫),。  
* **風險控制**：  
  * **INV-T1-OVERNIGHT**：次日 10:00 前必須完成隔夜風控檢查，若未完成則觸發告警。  
  * **NWOG 檢核**：必須執行 NWOG (New Week Opening Gap) 檢核，依據檢核結果執行風險降級 (risk\_downshift) 或調整偏見。

### **6.2.3 產物隔離與路由 (Artifact Isolation & Routing)**

依據「方案 B」的自動化骨架設計，T0 與 T1 模式共用大部分的程式碼與基礎設施，但在 **數據產出 (Artifacts)** 與 **證據指標 (Evidence Pointers)** 上必須實施嚴格的物理隔離，以防止風險分析失準,,。

**隔離策略 (Isolation Strategy)** 開發者應採用以下目錄結構進行隔離，嚴禁混用：

1. **子目錄隔離 (Sub-directory Isolation) \[推薦\]**：

   * T0 產物路徑：`/spartoi_flow/{date}/t0_daytrade/`  
   * T1 產物路徑：`/spartoi_flow/{date}/t1_swing/`  
   * 此策略符合 Runbook v2.0.0 的規範。  
2. **證據指標分離 (Evidence Pointer Split)**：

   * 若 T0 與 T1 的輸入/輸出內容完全相同（如共用的市場行情資料），可共用證據指標，並在 Manifest 中標註 `route: [T0, T1]`。  
   * 若內容不同（如 StoryCard、OrderLog），**必須** 分離 evidence\_ptr，路徑中必須明確包含 `/t0/` 或 `/t1/`。

**Fail-Closed 判定**

* 若偵測到 `order_log` 或 `risk_report` 中混雜了 T0 與 T1 的數據（例如 T0 帳本出現隔夜部位），視為治理失控，Gate 必須 **BLOCK\_RELEASE**。

### **6.2.4 子系統共用與分流矩陣 (Subsystem Split Matrix)**

在 OMOC 執行平面中，各 CA 子系統對 T0/T1 的支援程度不同。依據架構定義，部分子系統為共用（Common），部分則需分流（Split）處理。

| 子系統 (Subsystem) | T0 支援 | T1 支援 | 分流類型 (Type) | 執行行為與職責差異 |
| ----- | ----- | ----- | ----- | ----- |
| **CA-WRC** | ✅ | ✅ | **共用** | 教材來源無分流，知識庫統一管理。 |
| **CA-CORPUS** | ✅ | ✅ | **共用** | 語料庫無分流，共用索引與檢索。 |
| **CA-DISTILL** | ✅ | ✅ | **共用** | 蒸餾邏輯無分流，產出通用 ICT 模組。 |
| **CA-DSL** | ✅ | ✅ | **共用** | 原語庫無分流，DSL 語法通用。 |
| **CA-METHOD** | ✅ | ✅ | **分流** | T1 需產出專屬 `MethodCard_T1` 與 `RiskCard_T1`,。 |
| **CA-BACKTEST** | ✅ | ✅ | **分流** | T1 回測需增加隔夜風險 (Gap Risk) 與事件風險 (Event Risk) 的模擬。 |
| **CA-TA** | ✅ | ✅ | **共用** | 技術指標計算邏輯通用，無分流。 |
| **CA-SELECT** | ✅ | ✅ | **共用** | 選股邏輯通用，縮表邏輯一致。 |
| **CA-TRANSLATE** | ✅ | ✅ | **共用** | XS 轉譯邏輯通用，僅參數不同。 |
| **CA-WATCH** | ✅ | ✅ | **分流** | T1 需增加隔夜部位監控與開盤跳空 (Gap) 監控。 |
| **CA-EXECUTE** | ✅ | ✅ | **分流** | T0 強制 13:20 平倉；T1 允許隔夜持倉但需執行收盤前風控檢查,。 |
| **CA-PERFORM** | ✅ | ✅ | **分流** | T1 需增加隔夜績效指標 (Overnight Exposure, Gap PnL)。 |
| **CA-COLLAB** | ✅ | ✅ | **共用** | Agent 協作模式無分流。 |
| **CA-UI** | ✅ | ✅ | **分流** | T1 需在 UI 上呈現隔夜部位視圖與次日出場計畫。 |
| **CA-GOVERN** | ✅ | ✅ | **分流** | T1 需加載隔夜風控規則與特定的 Kill Switch 條件。 |

**自動化實作指引 (方案 B)** 在 GitHub Actions Workflow 中，應使用 `matrix` 策略來處理這種分流，例如：

strategy:  
  matrix:  
    mode: \[T0\_DAYTRADE, T1\_SWING\]

Pipeline 在執行時會讀取 `mode` 參數，並根據上述矩陣動態載入對應的 Config 與 Gate 規則，確保「單一流水線」能同時滿足雙模運行的需求,。

---

## 6.3 ICT 模組與熱插拔 (ICT Modules & Hot-Swap)

本節詳述 Spartoi 系統中核心交易邏輯模組（ICT Modules）的架構定義與管理機制。依據《Spartoi-OMOC\_開發實作方案.md》與《Spartoi｜P1\_ARCH\_v6.0.0-r5.md》，系統採用「雙鍵綁定」與「四路徑熱插拔」機制，實現交易策略的「一次定義、多次複用、可版本回退」，並由 CA-METHOD 負責 Registry 維護，CA-GOVERN 負責熱插拔控制。  
---

#### **6.3.1 雙鍵綁定機制 (Dual-Key Binding)**

為了實現架構與實作的解耦，以及支援動態調整，ICT 模組必須遵循「雙鍵綁定」原則，嚴禁單鍵引用。

**1\. 雙鍵定義 (The Two Keys)** 系統利用 `slot_key` 與 `methodcard_key` 的組合作為模組的唯一識別與版本控制依據：

* **Slot Key (槽位鍵)**：  
  * **定義**：ICT 模組的抽象槽位標識（\#1-\#107），對應原始技術編號與功能分類。  
  * **性質**：固定不變，代表「這個位置是用來做什麼的」（例如：\#19 代表 BOS/CHoCH）。  
  * **格式**：大寫字母+底線（如 `WEEKLY_BIAS`）。  
* **MethodCard Key (方法卡鍵)**：  
  * **定義**：方法卡的唯一實作標識（methodcard\_id \+ version），指向該槽位當下具體執行的邏輯版本。  
  * **性質**：可變動，代表「這個位置現在是用哪個版本的代碼來執行」。  
  * **預設值**：在方法卡尚未定案前，必須填入 `PLACEHOLDER_PENDING_CA_METHOD`。

**2\. 綁定關係與狀態**

* **1:N 映射**：一個 `slot_key` 可以擁有多個歷史版本的 `methodcard_key`，但在任一時間點，只有一個 MethodCard 處於 `ACTIVE` 狀態。  
* **綁定升級路徑**：`PLACEHOLDER` → `BOUND`。當 CA-METHOD 產出對應 MethodCard，且通過 SEM³ 三 Gate 驗證與回測（GATE-BACKTEST-PASS）後，方可更新為實際 ID。

**3\. 解析規則 (R1-R5 Rules)** 綁定過程必須通過以下五條硬性規則檢核，任一失敗則觸發 Fail-Closed：

| 規則 ID | 規則名稱 | 檢核內容 | Fail-Closed 行為 | 來源 |
| ----- | ----- | ----- | ----- | ----- |
| **R1** | **Slot Key Exact Match** | `slot_key` 必須在 Technique Registry (\#1-\#107) 中精確匹配。 | 不匹配 → `SLOT_NOT_FOUND`，綁定失敗。 |  |
| **R2** | **MethodCard Key Version** | `methodcard_key` 的版本號必須與該 Slot 的要求相容 (SemVer)。 | 不相容 → `VERSION_MISMATCH`，綁定失敗。 |  |
| **R3** | **Registry Lookup** | 查詢 Registry 確認技法狀態，必須為 `ACTIVE`。 | 查無或 `DEPRECATED` → `TECHNIQUE_NOT_FOUND` 或警告。 |  |
| **R4** | **Hot-Swap Path Validation** | 驗證熱插拔路徑是否合法 (DISABLED / REPLACED / ROLLBACK / A-B\_TEST)。 | 非法路徑 → `PATH_INVALID`。 |  |
| **R5** | **Fail-Closed on Resolution** | 若上述任一規則失敗，整體綁定操作必須原子性失敗，保持原狀態。 | 解析失敗 → `BINDING_FAILED`，不進行部分綁定。 |  |

#### **6.3.2 四路徑熱插拔 (4-Path Hot-Swap)**

系統必須支援四種標準化的模組切換路徑，以應對策略失效、版本升級或緊急回滾的需求。所有切換操作均需具備原子性，並記錄於 `hotswap_log.jsonl`。

**1\. 熱插拔路徑定義**

| 路徑名稱 | 觸發條件 | 系統行為 | Fail-Closed / 驗收標準 | 來源 |
| ----- | ----- | ----- | ----- | ----- |
| **DISABLED** (停用) | 人工停用請求 | 標記狀態為 `INACTIVE`，Slot 清空但保留歷史記錄。 | 訊號產生時 Skip；停用失敗則 `BLOCK_RELEASE`。 |  |
| **REPLACED** (替換) | 新版策略上線 | 新版 MethodCard 覆蓋舊版，舊版降級為 `DEPRECATED`。 | 須通過 `golden_test` 驗證；若新版驗證失敗 → 自動回滾。 |  |
| **ROLLBACK** (回滾) | 回滾請求 / 替換失敗 | 恢復至指定的歷史版本，狀態重置為 `ACTIVE`。 | 若目標版本不存在 → `FAIL`；回滾失敗 → 進入安全模式 (RADAR\_ONLY)。 |  |
| **A-B TEST** (對照) | 對照驗證需求 | 雙版本並行運作：主版本執行交易，影子版本僅記錄結果。 | 不影響交易執行；需產出對照報告。 |  |

**2\. 連鎖處置機制 (Cascading Failure Handling)** 當某個 ICT 模組被標記為 `DEPRECATED` 或失效時，系統必須執行連鎖處置，防止依賴該模組的交易繼續執行：

1. **掃描**：掃描所有運行中且狀態為 `ACTIVE` 的故事卡 (StoryCard)。  
2. **標記**：檢查 `ict_modules_ref` 欄位，標記所有引用失效模組的故事卡。  
3. **降級**：將受影響的故事卡標記為 `DEGRADED`。  
4. **阻斷**：**禁止**基於該故事卡的新進場訊號 (BLOCK)。  
5. **出場**：現有倉位依原計畫執行出場，但**禁止加碼**。  
6. **Fail-Closed**：若故事卡狀態更新失敗，系統強制進入 `RADAR_ONLY` 模式，物理阻斷進入 EXECUTE 階段。

#### **6.3.3 模組索引 (Module Indexing \#1\~\#107)**

Spartoi 系統嚴格鎖定 ICT 模組的範圍與編號，建立全域唯一的模組索引，作為所有自動化流程的基礎。

**1\. 索引範圍與來源**

* **範圍**：固定為 **ICT \#1 \~ \#107**，涵蓋從週偏見到微觀結構的所有技法。  
* **SSOT**：模組索引的唯一真理來源為 `ICT股票分析總表_v1_2_1.md`。  
* **存放位置**：工程實作上，索引檔位於 `/spartoi_flow/technique_inventory/technique_inventory.jsonl`。

**2\. 索引結構 (Schema)** Registry 中的每個條目必須包含以下最小欄位：

{  
  "technique\_id": "string (ICT \#1-\#107)",  
  "slot\_key": "string (e.g., WEEKLY\_BIAS)",  
  "methodcard\_key": "string (e.g., MC-001:v1.0.0)",  
  "status": "enum (ACTIVE|DISABLED|REPLACED|DEPRECATED)",  
  "evidence\_ptr": "string (source evidence reference)",  
  "activated\_at": "timestamp",  
  "deactivated\_at": "timestamp|null"  
}

**3\. 驗收與抽驗規則** 為了確保索引的完整性與正確性，系統執行每日盤前自動抽驗 (SF-03 之前)：

* **完整性**：總記錄數必須等於 107 條，且編號連續無跳號。  
* **格式合規**：`entry_id` 必須符合 `ICT-M###` 格式；`locator` 必須非空且可回放定位。  
* **Fail-Closed**：  
  * 若發現記錄缺失 (\<107) 或格式錯誤 → **BLOCK\_RELEASE**。  
  * 若 `methodcard_key` 為 `PLACEHOLDER` 但嘗試執行交易 → **RADAR\_ONLY** (僅觀測)。  
  * 若狀態為 `DEPRECATED` 但嘗試引用 → **BLOCK**。

**4\. Legacy Token 政策**

* **舊編號處理**：舊版文件中的 `ICT-0` \~ `ICT-9` 或 `#1-#98` 等編號，被視為 **Legacy Token**。  
* **使用限制**：Legacy Token **僅允許**出現在 `Crosswalk` (附錄對照表) 中，嚴禁在正文、代碼邏輯或新版產物中使用。  
* **轉換規則**：所有 Legacy Token 必須透過 `Crosswalk` 表格轉換為標準的 `ICT-M###` 格式後方可使用。

# ---

 **7\. 證據鏈與驗收 (Evidence & Acceptance)**

本章定義如何證明任務「做對了」。  
---

## **7.1 Evidence Pack (證據包)**

本章節定義 Spartoi-OMOC 架構中「證據（Evidence）」的實體結構與驗收標準。依據《Spartoi-OMOC\_開發實作方案.md》定義的「方案 B」原則，我們不自研複雜的證據鏈平台，而是利用 **GitHub Actions** 與 **OMOC** 的原生能力，產出標準化的「證據三件套（The Triad）」。此機制是實現「人工只看 PASS」與「Fail-Closed（預設阻斷）」的核心基礎。  
---

### **7.1.1 證據三件套 (The Evidence Triad)**

在 Spartoi-OMOC 的執行平面（Execution Plane）中，任何 Pipeline 或 Task 的執行結果，都必須具現化為以下三個不可分割的檔案。若缺乏任一檔案，控制平面（Control Plane）必須視為 **BLOCK\_RELEASE**（阻斷發布）。

#### **1\. manifest.json (執行清單)**

這是單次執行（Run）的「身分證」，負責記錄輸入、輸出與環境指紋，確保可追溯性。

* **生成者**：由 OMOC Agent 在執行結束時透過 `collect-evidence` 指令生成。  
* **必填欄位契約 (Schema Contract)**：  
  * `run_id` (UUID): 全域唯一的執行識別碼，必須與 GitHub Actions Run ID 關聯。  
  * `timestamp` (ISO8601): 執行時間戳。  
  * `inputs`: 輸入檔案清單及其 SHA-256 雜湊值（Input Seal），防止「換料欺詐」。  
  * `outputs`: 產出檔案清單及其 SHA-256 雜湊值。  
  * `env_fingerprint`: 執行環境的指紋（如 Docker Image Hash），確保環境一致性。  
  * `pipeline_id`: 所屬管線（A/B-Strategy/B-Learn/C）。  
  * `skills_used`: 本次執行所調用的 Skills 清單，用於供應鏈審計。

#### **2\. gate\_report.json (閘門報告)**

這是控制平面的「判決書」，記錄所有 Gate 的檢核結果。

* **生成者**：由 **GateRunner**（運行於控制平面）執行檢核後產出，嚴禁由 LLM 自行撰寫。  
* **必填欄位契約**：  
  * `gate_id`: 對應的 Gate ID（如 `G-SRC`, `G-SCHEMA`）。  
  * `gate_result`: 判定結果，僅限 `PASS` | `FAIL` | `SKIPPED` | `CONDITIONAL`。  
  * `evidence_ptr`: 指向具體證據檔案的路徑（如 `/evidence/g-src/report.json`）。  
  * `violation_log`: 若失敗，必須包含違規細節。

#### **3\. artifacts/ (實體產物)**

這是實際的交付物，必須依據標準目錄結構存放，並與 `manifest.json` 中的雜湊值完全匹配。

* **內容範例**：  
  * 方法卡 (`method_card.json`)  
  * 分析包 (`ta_pack.json`)  
  * XS 腳本包 (`xs_script_pack.zip`)  
  * 差異報告 (`diff/`)  
* **完整性驗證**：控制平面必須校驗 `artifacts/` 下檔案的 SHA-256 是否與 `manifest.json` 宣告的一致，不一致則視為篡改，觸發 **Fail-Closed**。

### **7.1.2 裁決機制 (Verdict Mechanism)**

為了達成「零人工核准（No-Human-Approval）」的安全性，系統必須建立「Layer-1 機械裁決」機制，嚴格禁止依賴 LLM 的自然語言總結作為最終判斷依據。

#### **1\. verdict.json (第一層機械裁決)**

* **定位**：這是 Runner/Orchestrator 的 **唯一** Layer-1 裁決輸出。它是機械產生的、可稽核的、可重放的 JSON 檔案。  
* **禁令**：LLM（Layer-2）只能生成如 `review_findings.json` 的「解釋性」內容，**絕對不得** 修改或生成 `verdict.json` 中的 `overall.status`。  
* **Fail-Closed 邏輯**：  
  * 若 `verdict.json` 缺失或欄位不全 → `exit non-zero` → **BLOCK\_RELEASE**。  
  * 若 `verdict.json` 的 `overall.status` 與 `gate_report.json` 的彙總結果不一致 → **BLOCK\_RELEASE**。

#### **2\. 供應鏈簽章 (Artifact Attestations)**

* **機制**：利用 GitHub Actions 的 `actions/attest-build-provenance` 對上述證據包進行數位簽章，生成不可偽造的 SLSA Provenance。  
* **驗證**：在合流（Merge）前，系統必須使用 `gh attestation verify` 指令驗證產物的來源與完整性。若驗證失敗（簽章無效或雜湊不符），視為驗收失敗。這是取代自研證據鏈的核心「現成輪子」方案。

### **7.1.3 回放契約 (Replay Contract)**

為了確保開發過程的可追溯性與可除錯性，證據包必須滿足不同層級的回放標準（Replayability Levels）。此標準由控制平面強制執行。

#### **L1-Audit (可追溯)**

* **定義**：足以證明「誰、何時、做了什麼、結果為何」。  
* **最小材料**：`manifest.json` \+ `gate_report.json` \+ `run_log.md`。  
* **用途**：合規審計、歷史查詢。

#### **L2-Reproduce (可重現)**

* **定義**：在相同環境下，能夠重新執行並得到相似結果。  
* **最小材料**：L1 材料 \+ `inputs_hash.json` \+ `environment_snapshot.yaml`（含 Docker Image ID、Env Vars）。  
* **用途**：除錯（Debug）、環境漂移偵測。

#### **L3-Replay (可重跑)**

* **定義**：具備完整的輸入與執行腳本，可完全自動化地重新執行整個 Pipeline。  
* **最小材料**：L2 材料 \+ `executable_artifacts/`（可執行檔）+ `golden_set/`（黃金測試集）+ `replay_script.sh`。  
* **用途**：回歸測試（Regression Testing）、災難復原。

### **7.1.4 證據落盤與目錄結構**

所有證據必須依據統一的目錄結構進行「落盤（Landing）」，嚴禁散落在隨機目錄。此結構直接對應到 Artifact Store 的儲存邏輯。

/evidence/  
├── {run\_id}/  
│   ├── manifest.json           \# 核心：輸入/輸出/Hash  
│   ├── gate\_report.json        \# 核心：Gate 判定結果  
│   ├── verdict.json            \# 核心：Layer-1 機械裁決  
│   ├── orchestration\_log.json  \# 流程日誌  
│   ├── gates/  
│   │   └── {gate\_id}/  
│   │       └── gate\_report.json \# 個別 Gate 的詳細報告  
│   ├── artifacts/  
│   │   └── {artifact\_type}/     \# 實際產出物 (MethodCard, XS Script...)  
│   └── diff/                   \# 變更差異 (若有)  
└── index.json                  \# 全域索引

*(來源：)*

**Fail-Closed 存取規則**：

* **寫入**：Agent 在執行過程中僅能寫入 `artifacts/` 與 `diff/`，嚴禁修改 `manifest.json` 與 `verdict.json`（由控制平面寫入）。  
* **讀取**：GateRunner 讀取此目錄進行驗證。若目錄結構不符或關鍵檔案缺失，GateRunner 直接回報 **FAIL**。

---

## **7.2 驗收體系 (Acceptance System)**

驗收體系由三大支柱構成：**MAI (主驗收索引)** 負責將每一條需求綁定至具體的驗收工件；**RTM (需求追溯矩陣)** 負責確保上游需求無遺漏地映射至實作；**Fitness Functions (適應度函數)** 負責量化系統的架構品質與演進方向。  
---

### **7.2.1 MAI (Master Acceptance Index)：主驗收索引**

MAI 是系統驗收的「唯一真理索引」，它強制規定每一條 SRS 需求（Requirement）都必須對應一個可被檢核的驗收工件（Acceptance Artifact）與驗證方法。

#### **1\. MAI 結構定義 (Structure Definition)**

依據 P1\_SRS v7.0.0，MAI 條目必須包含以下核心欄位，缺一不可：

* **mai\_id**: MAI 唯一識別碼 (如 `MAI-SF-001`)。  
* **srs\_req\_id**: 對應的 SRS 需求 ID。  
* **acceptance\_artifact**: 驗收必需產出的工件名稱 (如 `sf_coverage_report.json`)。  
* **verification\_method**: 驗證手段，限定為 `Inspection` (檢視)、`Demo` (演示)、`Test` (測試)、`Analysis` (分析) 四類。  
* **gate\_ref**: 關聯的 Gate ID，用於自動化阻斷 \[SRS v7.0.0 §10.1\]。

#### **2\. 驗收索引分類 (Index Categories)**

MAI 依需求類型分為五大索引，確保不同維度的需求皆被覆蓋：

**(A) FR 驗收索引 (Functional Requirements)** 核心功能需求的驗收映射，確保業務邏輯正確落地。

* **SF 主流程**: `MAI-SF-001` 驗證 `sf_coverage_report.json` (Inspection) \[SRS v7.0.0 §10.2\]。  
* **JobCard**: `MAI-JOBCARD-001` 驗證 `jobcard_schema_validation.json` (Test) \[SRS v7.0.0 §10.2\]。  
* **WRC 教材**: `MAI-WRC-001` 驗證 `wrc_source_report.json` (Test) \[SRS v7.0.0 §10.2\]。  
* **SEM³ 驗證**: `MAI-SEM3-001` 驗證 `sem3_gate_report.json` (Test) \[SRS v7.0.0 §10.2\]。  
* **HITL (人機迴圈)**: `MAI-HITL-DP-001` 驗證 `decision_package_schema_test.json` (Inspection) \[SRS v7.0.0 §10.2\]。

**(B) NFR 驗收索引 (Non-Functional Requirements)** 非功能需求的驗收映射，確保系統品質達標。

* **延遲**: `MAI-LAT-001` 驗證 `latency_report.json` (Test) \[SRS v7.0.0 §10.3\]。  
* **安全性**: `MAI-NFR-SEC-001` 驗證 `security_audit.json` (Inspection) \[SRS v7.0.0 §10.3\]。  
* **可觀測性**: `MAI-NFR-OBS-001` 驗證 `observability_report.json` (Analysis) \[SRS v7.0.0 §10.3\]。  
* **LLM 可靠度**: `MAI-LLM-001` 驗證 `llm_dependency_audit.json` (Inspection) \[SRS v7.0.0 §10.3\]。

**(C) IR 驗收索引 (Interface Requirements)** 介面契約的驗收映射，確保子系統間通訊合規。

* **控制面三件套**: `MAI-CTRL-001` 驗證 `ctrl_trio_validation.json` (Test) \[SRS v7.0.0 §10.4\]。  
* **降級矩陣**: `MAI-DEGRADE-001` 驗證 `degrade_matrix.json` (Inspection) \[SRS v7.0.0 §10.4\]。  
* **XQ 整合**: `MAI-XQ-001` 驗證 `xq_integration_test.json` (Test) \[SRS v7.0.0 §10.4\]。

**(D) GOV 驗收索引 (Governance Requirements)** 治理政策的驗收映射，確保合規與防漂移。

* **Route-Out 政策**: `MAI-GOV-001` 驗證 `routeout_audit.json` (Inspection) \[SRS v7.0.0 §10.5\]。  
* **ICD Token**: `MAI-GOV-003` 驗證 `icd_token_check.json` (Inspection) \[SRS v7.0.0 §10.5\]。  
* **設計假說驗證 (H1-H8)**: 例如 `MAI-HYP-H1-001` (SEM³) 驗證 `sem3_pipeline_test.json` \[SRS v7.0.0 §10.5\]。

**(E) CR\_OPEN 驗收索引 (Candidate Requests)** 針對未定案門檻的驗收，確保所有 Candidate 轉為 CR\_OPEN 並受監控。

* **Win Rate**: `MAI-WIN-001` 對應 `win_rate_report.json` (BLOCK\_RELEASE) \[SRS v7.0.0 §10.6\]。  
* **TVE 驗證**: `MAI-TVE-001` 對應 `tve_report.json` (BLOCK\_RELEASE) \[SRS v7.0.0 §10.6\]。

#### **3\. MAI 同步驗證機制 (Synchronization & Fail-Closed)**

為防止 MAI 與實際需求脫鉤，系統執行以下硬性同步檢查：

* **SRS-MAI-SYNC-001**: 若 MAI 以外掛檔案承載，系統 MUST 驗證外掛存在、Hash 一致且與正文統計相符。任一不一致觸發 **Fail-Closed (BLOCK\_RELEASE)** \[SRS v7.0.0 §10.7\]。  
* **SRS-MAI-VERIFY-001**: MAI 條目數必須等於 SRS 需求條文數，確保 100% 覆蓋 \[SRS v7.0.0 §10.7\]。

---

### **7.2.2 RTM (Traceability Matrix)：需求追溯矩陣**

RTM 負責建立從「上游權威文件」到「SRS 需求」再到「實作/驗收」的雙向追溯鏈。本系統維護四層 RTM 以覆蓋不同層級的來源。

#### **1\. RTM-P0 (P0-Q\&A 日常任務映射)**

將最高權威 P0-Q\&A 定義的 12 項日常任務 (a-m) 映射至 SF 主鍵流程與子系統。

* **覆蓋率**: 100% (13 條任務，原文無 e) \[SRS v7.0.0 §12.1\]。  
* **範例**: 任務 `a` (教材蒐集+蒸餾) 映射至 `SF-00`, `CA-WRC`, `CA-CORPUS`, `CA-DISTILL`，Gate 為 `GATE-RL-001` \[SRS v7.0.0 §12.1\]。

#### **2\. RTM-A (StRS+SyRS 上位需求映射)**

將上位需求書 (StRS/SyRS) 的 74 條需求映射至 SRS 條文。

* **機制**: 系統 MUST 提供 RTM-A 全量外掛工件 (`rtm_a_full.json`)，且 Hash 須與 Manifest 一致，否則 **Fail-Closed** \[SRS v7.0.0 §12.2\]。  
* **Disposition**: 每條需求標記為 Covered, Route-Out 或 CR\_OPEN \[SRS v7.0.0 §12.2\]。

#### **3\. RTM-REQ21 (核心 21 項需求映射)**

針對 `Spartoi系統21項需求` 進行逐條硬性映射。

* **覆蓋率**: 100% (21/21) \[LBP-A v6.0.0-r2 §14.1\]\[SRS v7.0.0 §12.3\]。  
* **關鍵映射**:  
  * REQ\#4 (No-API) → `FIT-004`, `CR-OPEN-E-004` \[LBP-E v3.0.1 §7.1\]。  
  * REQ\#5 (SEM³) → `FIT-008`, `FIT-009` \[LBP-E v3.0.1 §7.1\]。  
  * REQ\#20 (唯一下單端 XQ) → `FIT-010`, `FIT-006` \[LBP-E v3.0.1 §7.1\]。

#### **4\. RTM-B (RS-B 補齊需求映射)**

針對 `RS-B` (待補充需求庫) 的 642 條需求進行映射。

* **機制**: 使用外掛檔案 `rtm_rsb_full_642.tsv` 進行全量追溯。系統禁止以抽樣結果宣稱全量覆蓋，Hash 不一致即 **Fail-Closed (BLOCK\_RELEASE)** \[SRS v7.0.0 §12.4\]。  
* **狀態**: Covered: 580, Route\_Out: 30, CR\_OPEN: 32 \[SRS v7.0.0 §12.0\]。

#### **5\. 架構層 RTM 映射 (Architecture Mapping)**

將 REQ21 需求映射至 ARCH 的 15 個子系統與關鍵構件。

* 例如 REQ21-08 (No-API 政策) 映射至 `CA-COLLAB` (Agent 雙模) 與 `CA-GOVERN` (Orchestrator) \[ARCH v6.0.0-r5 §12.1\]。

---

### **7.2.3 Fitness Functions (適應度函數)**

Fitness Functions 是將抽象的品質屬性轉化為可執行的程式碼檢測，用於持續評估架構的健康度。本系統定義了 13 條核心 Fitness Functions (FIT-001 \~ FIT-013)。

#### **1\. Fitness Catalog (核心目錄)**

每條 Fitness Function 包含 `ff_id`、品質屬性、訊號定義、Pass/Fail 規則與 Gate 掛鉤。 \[LBP-E v3.0.1 §4\]

| ff\_id | 品質屬性 | 訊號定義 (Signal Definition) | Pass/Fail 規則 (Fail-Closed) | Gate 掛鉤 |
| ----- | ----- | ----- | ----- | ----- |
| **FIT-001** | Performance | **Win Rate**: 獲利交易數 / 總已平倉交易數 | 門檻未授權或缺 log → **RADAR\_ONLY** | GATE-RC-005 |
| **FIT-002** | Performance | **Profit Ratio**: 總獲利 / 總虧損 | 門檻未授權或缺報告 → **RADAR\_ONLY** | GATE-RC-005 |
| **FIT-003** | Performance | **Max Drawdown**: 最大回撤幅度 | 門檻未授權或缺報告 → **RADAR\_ONLY** | GATE-RC-005 |
| **FIT-004** | Reliability | **LLM Reliability**: Evals 通過率 | 報告缺失 → **RADAR\_ONLY** | GATE-RC-002 |
| **FIT-005** | Reliability | **Engineering Reliability**: 覆蓋率 \+ CI 通過率 | 報告缺失 → **RADAR\_ONLY** | GATE-RC-001 |
| **FIT-006** | Security | **Flag Consistency**: Hash(SRS Flags) \== Hash(ARCH Flags) | 不一致 → **BLOCK\_RELEASE** | GATE-GOV-003 |
| **FIT-007** | Semantic Fidelity | **TVE Equivalence**: XS 輸出 ≡ 本地基線 | 漂移 \> 閾值 → **RADAR\_ONLY** | GATE-RC-004 |
| **FIT-008** | Semantic Fidelity | **SGF Faithfulness**: 蒸餾輸出 vs 來源保真度 | 分數缺失 → **RADAR\_ONLY** | GATE-RC-002 |
| **FIT-009** | Semantic Fidelity | **MSC Conformance**: 方法卡 vs Schema 符合度 | 違規 → **RADAR\_ONLY** | GATE-RC-003 |
| **FIT-010** | Platform Parity | **MarketProfile Parity**: Hash(回測 MP) \== Hash(實盤 MP) | 不一致 → **EXECUTE\_DISABLED** | GATE-MP-001 |
| **FIT-011** | Binding Integrity | **ICT Binding**: (slot\_key, methodcard\_key) 雙鍵一致 | 缺失或不一致 → **FAIL** | GATE-RC-001 |
| **FIT-012** | Observability | **Obs Coverage**: 必要事件 ∩ 已記錄事件 / 必要事件 | 覆蓋率 \< 100% → **RADAR\_ONLY** | GATE-DQ-001 |
| **FIT-013** | Replayability | **Replay Determinism**: Hash(Run1) \== Hash(Run2) | 漂移偵測 → **BLOCK\_RELEASE** | GATE-RC-005 |

#### **2\. Evidence Hook (證據掛鉤)**

每條 Fitness Function 必須指向具體的 Pack 或 Log 落點，確保驗收有據可查。\[LBP-E v3.0.1 §5.1\]

* **FIT-007 (TVE)**: 必須產出 `tve_equivalence_report.json`，缺失則 **FAIL \+ 移除**。  
* **FIT-010 (MP Parity)**: 必須產出 `mp_parity_check.json`，缺失則 **EXECUTE\_DISABLED**。  
* **FIT-011 (ICT Binding)**: 必須產出 `ict_binding_check.json`，缺失則 **FAIL \+ 移除**。

#### **3\. TVE 閾值定義 (TVE Threshold Specifics)**

針對 FIT-007 (TVE)，定義具體的數值容錯率 \[整合平面工具鏈...報告 §6.2\]：

* **語義忠誠度 (BLEU Score)**: 邏輯分支出現差異的比例須為 **0%**。  
* **數值容錯率**: 回測中的進場/出場點位偏移須 **≤ 0.02%** (以台股最小跳動單位 Ticks 為準)。

#### **4\. CR\_OPEN 整合**

所有涉及數值門檻的 Fitness Function (如 FIT-001 Win Rate)，若門檻值未經 SRS 正式授權，必須登記為 **CR\_OPEN** 並預設採用 **RADAR\_ONLY** 或 **BLOCK\_RELEASE** 的保守策略，禁止私自放行 \[LBP-E v3.0.1 §6\]。

**FAIL-CLOSED AUDIT REPORT:**

* **覆蓋率檢查 (Coverage Check)**：已全量覆蓋來源《Spartoi-OMOC 工程實作指南：目錄（TOC）》中「8.1 日常作業」的所有子章節（8.1.1, 8.1.2）。  
* **主要依據 (Primary Source)**：內容邏輯嚴格遵循《Spartoi-OMOC\_開發實作方案.md》定義的「方案 B：單一流水線」與「P1/P2 分工邊界」。  
* **詳細規格 (Detailed Spec)**：細節參數與表格映射參照《Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md》與《Spartoi｜P1\_SRS\_v7.0.0.md》。  
* **未覆蓋項 (Missing)**：無。

---

# 8\. 運維與故障處置 (Operations & Failure Handling)

本章節定義系統運維的標準作業程序（SOP）與異常處理機制。依據《Spartoi-OMOC\_開發實作方案.md》，運維層的操作必須嚴格遵循「方案 B」的單一流水線（Single Pipeline）架構，透過參數化（CA\_ID）與 GitHub Matrix 來驅動 15 個 CA 工作站，並確保所有高風險操作符合「XQ 唯一下單端」與「HITL（Human-In-The-Loop）」的硬性約束。  
---

## 8.1 日常作業 (Daily Operations)

日常作業是 Spartoi P1 系統的核心心跳。為了確保「單人 \+ 多 AI」協作模式的穩定性，我們將 P0-Q\&A 定義的 13 項日常任務（Task a\~m）嚴格映射至 OMOC 的執行平面與 Spartoi Flow (SF) 主鍵體系。  
---

#### **8.1.1 P0 任務映射 (P0 Task Mapping)**

依據「權威堆疊（Authority Stack）」，P0-Q\&A 為最高權威，其定義的日常任務必須在執行平面中找到對應的自動化落點。在方案 B 架構下，這些任務不再是零散的腳本，而是透過 `orchestrate` CLI 或 OpenCode Agent 觸發的標準化 JobCard。

**A. 任務映射矩陣 (Task Mapping Matrix)**

下表將 P0 任務映射至具體的 SF 節點、負責的 CA 子系統以及 OMOC 的觸發方式。

| P0 任務 | 任務描述 | 對應 SF 節點 | 主要子系統 | OMOC 執行指令 (Scheme B) | 必產工件 (Evidence) | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **a** | **教材蒐集與蒸餾** | **SF-00, SF-01** | CA-WRC, CA-CORPUS, CA-DISTILL | `orchestrate --pipeline A --phase 0` | `input_manifest.jsoncorpus_snapshot.jsondistill_bundle.json` |  |
| **b** | **ICT × 台股在地實戰化** | **SF-00** | CA-DSL | `orchestrate --ca CA-DSL --mode spec` | `baseline_v1.vpc.yamldsl_schema.json` |  |
| **c** | **策略方法草案制定** | **SF-01** | CA-METHOD | `orchestrate --ca CA-METHOD --mode vibe` | `method_draft.json` |  |
| **d** | **建立台股歷史資料庫** | **SF-00** | CA-CORPUS (Historical) | `orchestrate --ca CA-CORPUS --task history` | `history_data_manifest.json` |  |
| **e** | **(任務 e 補齊)** | **SF-31** | CA-PERFORM | `orchestrate --ca CA-PERFORM --mode ops` | `daily_retro.json` |  |
| **f** | **回測/分析/修補循環** | **SF-01** | CA-BACKTEST, CA-METHOD | `orchestrate --pipeline B --phase 1` | `method_card_v1.jsonbacktest_report.json` |  |
| **g** | **產出日/周分析包** | **SF-01, SF-02** | CA-TA | `orchestrate --ca CA-TA --mode dev` | `weekly_pack.jsondaily_pack.json` |  |
| **h** | **XS 語法轉譯** | **SF-03** | CA-TRANSLATE | `orchestrate --ca CA-TRANSLATE --mode dev` | `xs_script.xstve_report.json` |  |
| **i** | **選股** | **SF-03, SF-08** | CA-SELECT | `orchestrate --ca CA-SELECT --mode ops` | `S1_final_list.jsonS2_final_list.json` |  |
| **j** | **XQ 盯盤發出訊號** | **SF-05, SF-09** | CA-WATCH | `orchestrate --ca CA-WATCH --mode ops` | `watch_log.jsonalert_evidence.json` |  |
| **k** | **手動確認進場→自動操盤** | **SF-06, SF-10** | CA-EXECUTE (HITL) | `orchestrate --ca CA-EXECUTE --mode ops` | `hitl_handoff.jsonexecution_log.json` |  |
| **l** | **績效分析→回饋方法** | **SF-13** | CA-PERFORM | `orchestrate --pipeline B-Learn` | `perf_summary.jsonfeedback_proposal.md` |  |
| **m** | **資料管理與版本化** | **SF-14** | CA-GOVERN | `orchestrate --ca CA-GOVERN --task sync` | `version_manifest.jsonssot_index.json` |  |

**B. 執行策略與約束**

為了符合「方案 B」的最短工期與低人工原則，上述任務的執行必須遵守以下技術約束：

1. **Orchestrator 作為單一入口**：

   * 所有任務 **必須** 通過 `./scripts/entrypoint.sh` 或 OpenCode 的 `orchestrate` 指令觸發。  
   * **禁止** 開發者直接進入子系統目錄執行 `python main.py`，以確保所有執行都被 `run_id` 追溯並產出 Evidence Pack。  
2. **JobCard 驅動**：

   * 每個 SF 節點執行時，系統 **必須** 實例化一張對應的 JobCard（如 `JC-WRC`, `JC-EXECUTE`）。  
   * JobCard 定義了該次執行的輸入（Inputs）、指令（Commands）、驗收標準（Acceptance）與回滾策略（Rollback）。  
3. **XQ 唯一下單端 (Fail-Closed)**：

   * 針對任務 **j (盯盤)** 與 **k (操盤)**，本地系統 **僅允許** 產出訊號文件（`watch_plan.json`）與 HITL 交接包（`hitl_handoff.json`）。  
   * **絕對禁止** 本地 Agent 直接透過 API 下單。若偵測到 Agent 嘗試調用下單 API，系統必須立即觸發 **Kill Switch (KS-007)** 並阻斷權限。  
4. **T0/T1 雙模分流**：

   * 執行任務 **k (操盤)** 時，必須明確指定 `--mode T0_DAYTRADE` 或 `--mode T1_SWING`。  
   * T0 模式下，若時間超過 13:20 仍有持倉，必須觸發強制清倉邏輯（INV-TIME-002）。

#### **8.1.2 每日抽驗 (Daily Spot Checks)**

在進入高風險的交易流程（SF-03 盤前選股）之前，系統必須執行一系列的自動化抽驗（Spot Checks），以確保基礎設施與規則庫的完整性。這是「Fail-Closed」原則在運維層的具體實踐。

**A. Crosswalk 一致性抽驗 (Crosswalk Audit)**

* **目的**：確保 `crosswalk.json`（ICT 模組索引 SSOT）與實際程式碼/文檔中的引用保持一致，防止「幽靈模組」或「斷鏈引用」。  
* **執行時機**：每日盤前（08:30 \- 09:00）。  
* **執行工具**：CA-GOVERN (via GateRunner)。  
* **驗證邏輯**：  
  * 從 `crosswalk.json` 中隨機抽取 10 條 ICT 模組（Seed: `{date}`）。  
  * 驗證 `locator` 是否可回放（即該錨點在來源文件中真實存在）。  
  * 驗證 `mapping_type` 與 `evidence_ptr` 的有效性。  
* **Fail-Closed 判定**：  
  * 單日抽驗失敗 ≥ 3 條 → 觸發 `GATE-CROSSWALK-AUDIT-FAIL`。  
  * 連續 3 日同一條目失敗 → **BLOCK\_RELEASE**（阻斷當日交易流程）。  
* **產出物**：`crosswalk_audit.log`。

**B. 連通性與環境指紋檢查 (Connectivity & Environment Check)**

* **目的**：確保執行環境（Codespaces/Local）與外部依賴（XQ/Data Source）連通且版本一致。  
* **執行工具**：`entrypoint.sh pre_xq`（基於 MinImpl Pack）。  
* **檢查項目**：  
  1. **XQ 連通性**：確認 XS 腳本編譯路徑可達，且 `xs_compile_log.txt` 可被讀取。  
  2. **環境指紋**：計算當前 Runtime（Node/Python 版本、依賴包 Hash）的指紋，並與 `run_config_snapshot.json` 比對。若不一致，視為環境漂移，阻斷執行。  
  3. **No-API 檢核**：確認核心路徑未依賴付費 LLM API。若發現 `REQUIRED_LLM > 0`，則觸發 **BLOCK\_RELEASE**。

**C. 每日驗收標準 (Daily Acceptance)**

每日運維流程必須滿足以下條件，方可視為「系統就緒（System Ready）」：

| 檢查項目 | 通過標準 | 失敗後果 | 來源 |
| ----- | ----- | ----- | ----- |
| **Crosswalk Audit** | 抽驗 10 條全數通過 (PASS) | ≥3 條失敗 → **RADAR\_ONLY** (標記風險) |  |
| **Connectivity** | XS 編譯成功且 XQ 可載入 | 失敗 → **BLOCK\_RELEASE** (阻斷交易) |  |
| **Environment** | 環境指紋與 Snapshot 一致 | 不一致 → **BLOCK\_RELEASE** |  |
| **Scope Lock** | 無 Legacy Token (OP-nn) 混入正文 | 發現 → **BLOCK\_RELEASE** |  |
| **Safety** | Kill Switch 狀態為 OFF | 狀態為 ON → **EXECUTE\_DISABLED** |  |

所有抽驗結果必須彙整至 `preflight_manifest.json`，作為當日 SF-00 (Preflight) 的輸入證據。

---

## **8.2 風險防線 (Risk Defense)**

本章節定義 Spartoi-OMOC 系統在遭遇異常、數據漂移或邏輯錯誤時的強制性防禦機制。依據「Spartoi-OMOC 開發實作方案」，所有的風險控制必須落實為「可執行的代碼契約」或「物理阻斷閘門」，絕不依賴人工的臨場判斷。  
---

### **8.2.1 Kill Switch：緊急熔斷機制 (Emergency Stop)**

Kill Switch 是系統最後一道物理防線，用於在極端風險發生時，強制切斷交易權限並執行清倉。依據《P1\_ARCH v6.0.0-r5》，Kill Switch 由 **CA-EXECUTE** 負責執行，並由 **CA-GOVERN** 進行狀態監控。

#### **1\. 核心定義與權威來源**

* **觸發原則**：Kill Switch 的觸發條件必須是「確定性」的（Deterministic），一旦滿足條件，系統必須立即執行，不得延遲或請求二次確認。  
* **執行邊界（XQ 唯一下單端）**：本地系統（OMOC Agent）僅負責發出「平倉/停止」的指令文件（Signal Artifact）；實際的清倉動作由「XQ 全球贏家」桌面端執行。本地端絕不可嘗試繞過 XQ API 進行直接下單。  
* **狀態聯動**：當 Kill Switch 被觸發，系統的降級矩陣（Degrade Matrix）必須立即切換至 `EMERGENCY_STOP` 模式，並阻斷所有 `EXECUTE` 路徑。

#### **2\. Kill Switch 矩陣 (KS-001 \~ KS-007)**

依據《Runbook & WI v2.0.0》，系統必須實作以下七種熔斷機制。任何新增或修改必須經過 CR\_OPEN 流程。

| KS ID | 名稱 | 觸發條件 (Trigger) | 執行效果 (Effect) | 對應 SF 節點 | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **KS-001** | **一鍵清倉** | 用戶主動觸發（透過 CA-UI）或偵測到帳戶權益急速虧損（\> 每日風控限額）。 | 立即對所有持倉發送市價平倉指令；停止所有新單。 | SF-06, SF-10 |  |
| **KS-002** | **DDmax 觸發** | 當日累計虧損達到最大回撤限制（Max Drawdown）。 | 平倉所有部位；鎖定當日交易權限（EXECUTE\_DISABLED）。 | SF-06, SF-10 |  |
| **KS-003** | **強清失敗** | 13:20 強制清倉時間點到達，但系統偵測到仍有未平倉部位。 | 發送緊急市價平倉指令（Emergency Market Order）；發送高優先級告警。 | SF-11 |  |
| **KS-004** | **系統異常** | 風控子系統（CA-GOVERN）失去回應或心跳（Heartbeat）停止。 | 全面暫停交易；Agent 降級為 NON\_AGENT 模式。 | SF-15 |  |
| **KS-005** | **數據延遲** | 即時行情數據延遲超過閾值（預設 1000ms，需 CR-008 驗證）。 | 全面暫停新單建立；若持倉中則維持監控或人工接手。 | SF-15 |  |
| **KS-006** | **LLM 異常** | LLM 協作過程中連續 3 次輸出不合規（Schema 錯誤或幻覺）。 | 暫停 LLM 輔助功能（SF-00）；系統降級至手動模式。 | SF-00 |  |
| **KS-007** | **Agent 異常** | Agent 模式下連續發生執行錯誤或震盪（Oscillation）。 | 強制切換為 NON\_AGENT 模式；阻斷自動化路徑。 | SF-16 |  |

#### **3\. 事件日誌與審計 (Evidence)**

每一次 Kill Switch 的觸發、確認與執行完成，都必須寫入控制面事件日誌（Control Plane Event Log），以滿足可稽核性。

* **必備事件**：  
  * `kill_switch_triggered`: 包含 `kill_type`, `trigger_reason`, `timestamp`。  
  * `kill_switch_executing`: 記錄執行進度。  
  * `kill_switch_completed`: 記錄最終狀態（成功/失敗）。  
* **Artifact**：生成的 `hitl_handoff.json` 中必須包含 `kill_switch_active: true` 標記。

---

### **8.2.2 Rollback：回滾與復原策略 (Rollback Strategy)**

當系統更新失敗、數據損毀或部署錯誤時，必須具備「一鍵回滾」至已知良好狀態（Last Known Good State）的能力。依據《Spartoi-OMOC 開發實作方案》，回滾機制不依賴 Git Revert，而是依賴不可變的「快照工件（Snapshot Artifacts）」。

#### **1\. 可回滾工件規格 (Snapshot Specification)**

所有回滾操作必須基於標準化的快照包，嚴禁手動複製貼上檔案。

* **命名規則**：`{task_id}_{timestamp}_snapshot.tar.gz`。  
* **保存路徑**：`/snapshots/`（本地或 Artifact Store）。  
* **保留策略**：預設保留 7 天（可配置）。  
* **差分報告**：每次回滾前必須產出 `rollback_diff.json`，內容包含：  
  * `changed_files`: 變更檔案清單。  
  * `hash_before`: 回滾前哈希值。  
  * `hash_after`: 預期回滾後哈希值。

#### **2\. 回滾矩陣 (RB-001 \~ RB-006)**

依據《Runbook & WI v2.0.0》與《Upgrade Plan v3》，定義以下回滾場景與策略。

| RB ID | 觸發條件 (Trigger) | 回滾策略 (Strategy) | 驗收標準 (Acceptance) | 來源 |
| ----- | ----- | ----- | ----- | ----- |
| **RB-001** | **Phase-N Gate FAIL** | 回退至 Phase-(N-1) 的最後成功狀態。 | `gate_report.json` 顯示前一階段為 PASS。 |  |
| **RB-002** | **Pack 損壞/缺失** | 使用上一版 Git Tag 或 Hash 的 Pack 進行覆蓋。 | `manifest.json` 中的 `bundle_hash` 驗證通過。 |  |
| **RB-003** | **Cowork 異常** | 停用 Cowork 功能，降級至人工操作路徑。 | `run_config_snapshot` 顯示 `cowork_enabled: false`。 |  |
| **RB-004** | **ICT 熱插拔失敗** | 恢復至模組替換前的版本（Previous Version）。 | `technique_registry.json` 顯示舊版狀態為 ACTIVE。 |  |
| **RB-005** | **Agent 執行震盪** | 強制中止當前 Session，重置 Context Window。 | Agent 重新初始化，無殘留 Context。 |  |
| **RB-006** | **資料落盤失敗** | 重試 3 次後若仍失敗，觸發人工介入（HITL）。 | 系統進入 `RADAR_ONLY` 模式，不執行新交易。 |  |

#### **3\. 執行流程與超時控制**

* **驗收流程**：  
  1. 執行回滾腳本。  
  2. 驗證復原後的檔案 Hash 與快照一致。  
  3. 執行 `G-ROLLBACK` Gate（歸類於 G5-F Execution），必須為 PASS。  
* **超時預算**：依據 CR\_OPEN-011，回滾操作必須在預設時間內完成（建議 30 秒，需驗證），否則視為回滾失敗，觸發更高級別的阻斷。

---

### **8.2.3 CR\_OPEN 管理：缺口與風險登記 (Gap & Risk Register)**

在 Spartoi-OMOC 架構中，「未經驗證的假設」或「待補全的功能」不得以模糊的 TODO 形式存在，必須轉換為 **CR\_OPEN (Open Change Request)** 並綁定 **Fail-Closed** 策略。這是防止「規格漂移（Spec Drift）」與「假性完工」的核心機制。

#### **1\. Candidate 遷移規則 (Governance Rule)**

依據《Candidate 處置規則 v2》，所有原始文件中的 Candidate（候選條款）必須強制遷移至 CR\_OPEN Register。

* **禁止事項**：  
  1. SRS 正文中不得出現 `<`、`>`、`≤`、`≥` 等未經授權的數值門檻。  
  2. 未經驗證的外部證據（如論壇貼文）不得直接升格為規範（Normative）。  
* **遷移流程**：  
  1. 識別未驗證條款。  
  2. 在 `APPX-I Candidate Migration Ledger` 登記遷移紀錄。  
  3. 在 CR\_OPEN Register 建立條目，並設定 `fail_closed_default`。

#### **2\. Fail-Closed 默認行為**

每條 CR\_OPEN 必須明確定義在該缺口未關閉前的系統行為。預設行為分為三級：

| 等級 | 行為定義 | 適用場景 |
| ----- | ----- | ----- |
| **BLOCK\_RELEASE** | 阻斷發布。不得宣稱 P1 階段完成，CI/CD Pipeline 直接失敗。 | 缺失關鍵證據、核心功能失敗（如 Win Rate 未達標）。 |
| **RADAR\_ONLY** | 允許運行與產出工件，但禁止進入 `EXECUTE` 階段。 | 門檻值未驗證、非核心功能缺口。 |
| **EXECUTE\_DISABLED** | 運行期禁用特定高風險動作（如自動下單）。 | Kill Switch 觸發、HITL 未確認、高風險 CR 未關閉。 |

#### **3\. CR\_OPEN 登記範例 (Evidence-Backed)**

以下為關鍵的 CR\_OPEN 登記項目，直接影響系統的可用性與安全性：

* **CR-OPEN-006 (XS/XSAT 能力邊界)**：  
  * **原因**：未取得 XS 語法官方文件，無法確認自動化邊界。  
  * **Fail-Closed**：`RADAR_ONLY`（僅能產出代碼，不可自動匯入執行）。  
  * **Evidence**：需補齊至少 2 筆 Evidence（P0 \+ External）。  
* **CR-OPEN-007 (XQ 自動操盤能力)**：  
  * **原因**：XQ 付費模組的自動化能力未經實測驗證。  
  * **Fail-Closed**：`RADAR_ONLY`（禁止無人值守交易）。  
* **CR-OPEN-008 (Data 延遲閾值)**：  
  * **原因**：500ms/1000ms 的延遲閾值缺乏實測數據支持。  
  * **Fail-Closed**：`BLOCK_RELEASE`（若無法監控延遲，則不允許上線）。  
* **CR-OPEN-024 (Ops Cowork 禁用)**：  
  * **原因**：Ops 環境下使用 Agent Cowork 存在安全風險。  
  * **Fail-Closed**：預設禁用（Disabled）。若偵測到 Cowork 使用，觸發 `BLOCK_RELEASE`。

#### **4\. 審計與關單 (Audit & Closure)**

* **關單條件**：必須滿足 Evidence Acquisition Protocol（每條至少 2 筆證據，含 1 筆外部來源），並經由 Gate 驗證通過（PASS）。  
* **追溯性**：所有 CR\_OPEN 的狀態變更必須記錄在 `issue_closure_matrix` 中，確保可追溯至原始 Issue 或 Candidate。

---

### **8.2.4 章節驗收標準 (Acceptance Criteria)**

本章節內容的落實需通過以下驗收檢查：

1. **Kill Switch 完整性**：KS-001 至 KS-007 在代碼與配置中均有對應實作，且測試（GT-SF14-001）通過。  
2. **回滾可執行性**：Rollback Matrix 中的策略已在 CI 環境中演練，且能成功恢復至快照狀態。  
3. **CR\_OPEN 覆蓋率**：所有未定案的參數與功能皆已登記為 CR\_OPEN，且無「裸奔」的 Candidate 條款殘留於 SRS 正文。  
4. **XQ 邊界守護**：所有自動化流程在接觸到下單指令時，均正確觸發了 HITL 或阻斷機制，無自動下單漏洞。

---

# **APPX-A. Crosswalk (Legacy & Mapping)**

本附錄是 Spartoi 系統中 **唯一允許出現 Legacy Token（舊術語/舊編號）** 的區域。所有舊版文件中的定義、流程編號與模組代碼，必須在此處與新版 SSOT（SRS v7.0.0 / ARCH v6.0.0-r5）建立精確的映射關係，以確保向後相容性與可追溯性。任何正文（Normative Part）出現 Legacy Token 皆視為違規 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]\[Spartoi｜P1\_LBP-A(SIR)\_v6[.0.0-r2.md](http://.0.0-r2.md)\]。  
---

### **A.1 目的與治理規約 (Purpose & Governance)**

* **唯一允許區 (Sanctuary)**：本附錄是系統中唯一合法存放 `DayFlow`、`ICT-xx`、`DF-xx`、`OP-nn` 等舊版術語的地方。  
* **禁止正文使用 (Prohibition)**：SRS、ARCH、LBP、Runbook 的正文區域嚴禁使用 Legacy Token，違者將被 `GATE-LEGACY-SCAN` 阻斷發布 \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]。  
* **用途限制 (Usage Limit)**：本對照表僅供「舊版文件遷移」與「歷史追溯」使用，**不得**作為新功能開發的主鍵或規範依據 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

### **A.2 Legacy Token Set (遺產符號集)**

以下 Token 被定義為 Legacy，正文零命中（Zero-Hit）政策適用：

| Token 類型 | Token 清單 | 說明 | 替代方案 (Current Norm) |
| ----- | ----- | ----- | ----- |
| **舊流程主鍵** | `DayFlow`, `DF0`\~`DF9`, `DF-0`\~`DF-9` | 舊版日流程編碼 | **SF-xx** (Spartoi Flow) |
| **舊操作主鍵** | `OP-00`\~`OP-14` | 舊版子系統操作編碼 | **SF-xx** (Spartoi Flow) |
| **舊階段編碼** | `ICT0`\~`ICT9`, `ICT-0`\~`ICT-9` | 舊版 ICT 階段編碼 | **SF-xx** 或 **Pipeline A/B/C** |
| **舊模組編號** | `ICT-#1`\~`ICT-#98` | 舊版 ICT 模組編號 | **ICT-M\#\#\#** (\#1\~\#107) |
| **舊分類名稱** | `九大項目` | 舊版功能分類 | **15 子系統 (CA-\*)** |
| **舊子系統** | `CA-FIREWALL` | 已刪除子系統 | 功能併入 **CA-GOVERN** |
| **禁用術語** | `層`, `分層`, `layer`, `Layer` | 易混淆術語 | 改用 **Tier** (旗標), **Level** (C4), **Section** (文件) |

*來源：\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]*

### **A.3 流程主鍵映射 (Process Key Mapping)**

此表定義 **Scenario (情境)** $\\leftrightarrow$ **SF (新主鍵)** $\\leftrightarrow$ **CA (子系統)** $\\leftrightarrow$ **Legacy (舊主鍵)** 的全量映射關係。

| SCN ID | Scenario Name | SF-\* (Primary) | CA-\* (Primary) | CA-\* (Secondary) | Legacy Ref (DayFlow) |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **SCN-001** | 蒸餾 | **SF-03** | CA-DISTILL | CA-CORPUS, CA-DSL | DF1 蒸餾 |
| **SCN-002** | 方法制定 | **SF-05** | CA-METHOD | CA-DSL, CA-BACKTEST | DF2 方法 |
| **SCN-003** | 回測 | **SF-06** | CA-BACKTEST | CA-METHOD, CA-TA | DF3 回測 |
| **SCN-004** | 選股 | **SF-08** | CA-SELECT | CA-TA, CA-UI | DF4 選股 |
| **SCN-005** | 轉譯 | **SF-09** | CA-TRANSLATE | CA-SELECT, CA-WATCH | DF5 轉譯 |
| **SCN-006** | 盯盤 HITL | **SF-10, SF-11** | CA-WATCH | CA-EXECUTE, CA-UI | DF6 盯盤 |
| **SCN-007** | 操盤 | **SF-12** | CA-EXECUTE | CA-WATCH, CA-PERFORM | DF7 操盤 |
| **SCN-008** | 績效 | **SF-13** | CA-PERFORM | CA-EXECUTE, CA-UI | DF8 績效 |
| **SCN-009** | Agent 雙模 | \- | CA-COLLAB | CA-EXECUTE, CA-UI | (N/A) |
| **SCN-010** | T0/T1 雙模 | \- | CA-EXECUTE | CA-METHOD, CA-PERFORM | (N/A) |
| **SCN-011** | 控制面 | \- | CA-GOVERN | CA-WATCH, CA-EXECUTE | (N/A) |
| **SCN-012** | ICT 綁定 | \- | CA-METHOD | CA-DSL, CA-BACKTEST | (N/A) |

*來源：\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]*

### **A.4 子系統映射 (Subsystem Mapping)**

定義舊版 SS 編號與新版 CA 代碼的對應，並標註已刪除的元件。

| 舊 SS 編號 | CA-\* 代碼 | 名稱 | 狀態 |
| ----- | ----- | ----- | ----- |
| SS-01 | **CA-WRC** | 白名單資源中心 | ACTIVE |
| SS-02 | **CA-CORPUS** | 語料庫管理 | ACTIVE |
| SS-03 | **CA-DISTILL** | 蒸餾引擎 | ACTIVE |
| SS-04 | **CA-DSL** | 純原語庫 | ACTIVE |
| SS-05 | **CA-METHOD** | 方法卡管理 | ACTIVE |
| SS-06 | **CA-BACKTEST** | 回測引擎 | ACTIVE |
| SS-07 | **CA-TA** | 技術分析 | ACTIVE |
| SS-08 | **CA-SELECT** | 選股篩選 | ACTIVE |
| SS-09 | **CA-TRANSLATE** | XS/XQ 轉譯 | ACTIVE |
| SS-10 | **CA-WATCH** | 盯盤監控 | ACTIVE |
| SS-11 | (Gate) | **SF-11 HITL Gate** (非子系統) | ACTIVE |
| SS-12 | **CA-EXECUTE** | 執行下單 | ACTIVE |
| SS-13 | **CA-PERFORM** | 績效分析 | ACTIVE |
| SS-14 | **CA-COLLAB** | 協作控制+Agent | ACTIVE |
| SS-15 | **CA-UI** | 使用者介面 | ACTIVE |
| SS-16 | **CA-GOVERN** | 治理控制 | ACTIVE |
| SS-17 | **CA-FIREWALL** | 防火牆 | **DELETED** (v6.0.0) |

*來源：\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]*

### **A.5 ICT 模組註冊表 (ICT Module Registry 1\~107)**

本表為 ICT 模組的 **SSOT 索引**，定義 `entry_id`、`ict_module_id`、`sf_ref` 與舊版 `locator` 的綁定關係。所有 ICT 模組引用必須使用 `ICT-M###` 格式。

*(以下內容全量整合自 Runbook v2.0.0 附錄 A)*

{  
  "crosswalk\_version": "1.0.0",  
  "source\_doc": "ICT股票分析總表\_v1\_2\_1.md",  
  "total\_entries": 107,  
  "entries": \[  
    {"entry\_id": "ICT-M001", "ict\_module\_id": "\#1", "ict\_module\_name": "Weekly Bias (WB)", "sf\_ref": "SF-01", "slot\_key": "WEEKLY\_BIAS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M002", "ict\_module\_id": "\#2", "ict\_module\_name": "W-DR/EQ50", "sf\_ref": "SF-01", "slot\_key": "WEEKLY\_RANGE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M003", "ict\_module\_id": "\#3", "ict\_module\_name": "W-PD Arrays", "sf\_ref": "SF-01", "slot\_key": "WEEKLY\_PD", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M004", "ict\_module\_id": "\#4", "ict\_module\_name": "W-TimeRisk", "sf\_ref": "SF-01", "slot\_key": "WEEKLY\_RISK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M005", "ict\_module\_id": "\#5", "ict\_module\_name": "W-LQ (Old Weekly H/L)", "sf\_ref": "SF-01", "slot\_key": "WEEKLY\_LQ", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M006", "ict\_module\_id": "\#6", "ict\_module\_name": "Daily Bias (DB)", "sf\_ref": "SF-02", "slot\_key": "DAILY\_BIAS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M007", "ict\_module\_id": "\#7", "ict\_module\_name": "D-DR/EQ50", "sf\_ref": "SF-02", "slot\_key": "DAILY\_RANGE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M008", "ict\_module\_id": "\#8", "ict\_module\_name": "D-PD Arrays", "sf\_ref": "SF-02", "slot\_key": "DAILY\_PD", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M009", "ict\_module\_id": "\#9", "ict\_module\_name": "IL/EL (Internal/External LQ)", "sf\_ref": "SF-02", "slot\_key": "DAILY\_LQ", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M010", "ict\_module\_id": "\#10", "ict\_module\_name": "Eco-Gate (08:30 embargo)", "sf\_ref": "SF-02", "slot\_key": "ECO\_GATE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M011", "ict\_module\_id": "\#11", "ict\_module\_name": "DR-Profile (Market Profile)", "sf\_ref": "SF-02", "slot\_key": "DAILY\_PROFILE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M012", "ict\_module\_id": "\#12", "ict\_module\_name": "ONR/Gap (Overnight Range)", "sf\_ref": "SF-03", "slot\_key": "PRE\_ONR", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M013", "ict\_module\_id": "\#13", "ict\_module\_name": "PM-Micro (Pre-Open Obs)", "sf\_ref": "SF-03", "slot\_key": "PRE\_MICRO", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M014", "ict\_module\_id": "\#14", "ict\_module\_name": "LQ-Rank (Draw on Liquidity)", "sf\_ref": "SF-03", "slot\_key": "LQ\_RANK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M015", "ict\_module\_id": "\#15", "ict\_module\_name": "SMT-Pairs", "sf\_ref": "SF-03", "slot\_key": "SMT\_PAIRS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M016", "ict\_module\_id": "\#16", "ict\_module\_name": "Model-WL/BL", "sf\_ref": "SF-03", "slot\_key": "MODEL\_FILTER", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M017", "ict\_module\_id": "\#17", "ict\_module\_name": "Judas Swing", "sf\_ref": "SF-11", "slot\_key": "JUDAS\_SWING", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M018", "ict\_module\_id": "\#18", "ict\_module\_name": "Power of Three (PO3)", "sf\_ref": "SF-11", "slot\_key": "PO3", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M019", "ict\_module\_id": "\#19", "ict\_module\_name": "BOS/CHoCH", "sf\_ref": "SF-11", "slot\_key": "BOS\_CHOCH", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M020", "ict\_module\_id": "\#20", "ict\_module\_name": "MSS (Market Structure Shift)", "sf\_ref": "SF-11", "slot\_key": "MSS\_DETECT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M021", "ict\_module\_id": "\#21", "ict\_module\_name": "FVG/Imbalance", "sf\_ref": "SF-11", "slot\_key": "FVG\_DETECT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M022", "ict\_module\_id": "\#22", "ict\_module\_name": "Order Block Suite", "sf\_ref": "SF-11", "slot\_key": "OB\_SUITE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M023", "ict\_module\_id": "\#23", "ict\_module\_name": "PD-Trade", "sf\_ref": "SF-11", "slot\_key": "PD\_TRADE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M024", "ict\_module\_id": "\#24", "ict\_module\_name": "OTE (Optimal Trade Entry)", "sf\_ref": "SF-11", "slot\_key": "OTE\_ZONE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M025", "ict\_module\_id": "\#25", "ict\_module\_name": "Turtle Soup (TS)", "sf\_ref": "SF-11", "slot\_key": "TURTLE\_SOUP", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M026", "ict\_module\_id": "\#26", "ict\_module\_name": "SMT Divergence", "sf\_ref": "SF-11", "slot\_key": "SMT\_DIVERGE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M027", "ict\_module\_id": "\#27", "ict\_module\_name": "Liquidity Raid→Reversal", "sf\_ref": "SF-11", "slot\_key": "RAID\_REVERSAL", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M028", "ict\_module\_id": "\#28", "ict\_module\_name": "Session-in-Session (SiS)", "sf\_ref": "SF-11", "slot\_key": "SIS\_MULTI", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M029", "ict\_module\_id": "\#29", "ict\_module\_name": "Kill Zones (LO/NY AM)", "sf\_ref": "SF-11", "slot\_key": "KZ\_AM", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M030", "ict\_module\_id": "\#30", "ict\_module\_name": "IDX-Legs (Intraday Legs)", "sf\_ref": "SF-11", "slot\_key": "IDX\_LEGS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M031", "ict\_module\_id": "\#31", "ict\_module\_name": "NY Lunch Risk", "sf\_ref": "SF-12", "slot\_key": "NYL\_RISK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M032", "ict\_module\_id": "\#32", "ict\_module\_name": "Lunch-Regime (Continuation vs Chop)", "sf\_ref": "SF-12", "slot\_key": "LUNCH\_REGIME", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M033", "ict\_module\_id": "\#33", "ict\_module\_name": "T-Exit (Time Exit)", "sf\_ref": "SF-12", "slot\_key": "TIME\_EXIT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M034", "ict\_module\_id": "\#34", "ict\_module\_name": "PM-Reframe", "sf\_ref": "SF-11", "slot\_key": "PM\_REFRAME", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M035", "ict\_module\_id": "\#35", "ict\_module\_name": "PM-Raid", "sf\_ref": "SF-11", "slot\_key": "PM\_RAID", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M036", "ict\_module\_id": "\#36", "ict\_module\_name": "SiS\#2 (Second Leg)", "sf\_ref": "SF-11", "slot\_key": "SIS\_LEG2", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M037", "ict\_module\_id": "\#37", "ict\_module\_name": "PM-SMT", "sf\_ref": "SF-11", "slot\_key": "PM\_SMT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M038", "ict\_module\_id": "\#38", "ict\_module\_name": "Target-Mgmt (Opposing LQ)", "sf\_ref": "SF-11", "slot\_key": "TARGET\_MGMT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M039", "ict\_module\_id": "\#39", "ict\_module\_name": "Close-Micro", "sf\_ref": "SF-14", "slot\_key": "CLOSE\_MICRO", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M040", "ict\_module\_id": "\#40", "ict\_module\_name": "Next-Bias", "sf\_ref": "SF-15", "slot\_key": "NEXT\_BIAS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M041", "ict\_module\_id": "\#41", "ict\_module\_name": "Event-Replay", "sf\_ref": "SF-15", "slot\_key": "EVENT\_REPLAY", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M042", "ict\_module\_id": "\#42", "ict\_module\_name": "R/DDmax (Risk Unit)", "sf\_ref": "SF-06", "slot\_key": "RISK\_UNIT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M043", "ict\_module\_id": "\#43", "ict\_module\_name": "Entry-Gate (5 Factor)", "sf\_ref": "SF-11", "slot\_key": "ENTRY\_GATE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M044", "ict\_module\_id": "\#44", "ict\_module\_name": "SL-Logic", "sf\_ref": "SF-11", "slot\_key": "SL\_LOGIC", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M045", "ict\_module\_id": "\#45", "ict\_module\_name": "Partial/Trail", "sf\_ref": "SF-11", "slot\_key": "PARTIAL\_TRAIL", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M046", "ict\_module\_id": "\#46", "ict\_module\_name": "News-Block", "sf\_ref": "SF-02", "slot\_key": "NEWS\_BLOCK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M047", "ict\_module\_id": "\#47", "ict\_module\_name": "Scale-in/out", "sf\_ref": "SF-11", "slot\_key": "SCALE\_INOUT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M048", "ict\_module\_id": "\#48", "ict\_module\_name": "Swing Tiers (SH/SL-Tier)", "sf\_ref": "SF-08", "slot\_key": "SWING\_TIER", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M049", "ict\_module\_id": "\#49", "ict\_module\_name": "EQH/EQL", "sf\_ref": "SF-08", "slot\_key": "EQ\_LEVELS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M050", "ict\_module\_id": "\#50", "ict\_module\_name": "Old H/L", "sf\_ref": "SF-08", "slot\_key": "OLD\_LEVELS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M051", "ict\_module\_id": "\#51", "ict\_module\_name": "Repricing/Rebalance", "sf\_ref": "SF-11", "slot\_key": "REPRICING", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M052", "ict\_module\_id": "\#52", "ict\_module\_name": "BRK/MB/INV (Block Variants)", "sf\_ref": "SF-11", "slot\_key": "BLOCK\_VARIANTS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M053", "ict\_module\_id": "\#53", "ict\_module\_name": "Displacement Candle", "sf\_ref": "SF-11", "slot\_key": "DISP\_CANDLE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M054", "ict\_module\_id": "\#54", "ict\_module\_name": "OTE-Fib (0.62-0.79)", "sf\_ref": "SF-11", "slot\_key": "OTE\_FIB", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M055", "ict\_module\_id": "\#55", "ict\_module\_name": "PD-25/50/75", "sf\_ref": "SF-11", "slot\_key": "PD\_TIERS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M056", "ict\_module\_id": "\#56", "ict\_module\_name": "KZ-Spec (Kill Zones Spec)", "sf\_ref": "SF-11", "slot\_key": "KZ\_SPEC", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M057", "ict\_module\_id": "\#57", "ict\_module\_name": "SiS-Template", "sf\_ref": "SF-11", "slot\_key": "SIS\_TPL", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M058", "ict\_module\_id": "\#58", "ict\_module\_name": "IDX-Profile (Range↔Trend)", "sf\_ref": "SF-08", "slot\_key": "IDX\_PROFILE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M059", "ict\_module\_id": "\#59", "ict\_module\_name": "NY AM Reversal", "sf\_ref": "SF-11", "slot\_key": "NYAM\_REV", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M060", "ict\_module\_id": "\#60", "ict\_module\_name": "NY AM Continuation", "sf\_ref": "SF-11", "slot\_key": "NYAM\_CONT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M061", "ict\_module\_id": "\#61", "ict\_module\_name": "PM Reversal", "sf\_ref": "SF-11", "slot\_key": "PM\_REV", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M062", "ict\_module\_id": "\#62", "ict\_module\_name": "Gap-Fill", "sf\_ref": "SF-11", "slot\_key": "GAP\_FILL", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M063", "ict\_module\_id": "\#63", "ict\_module\_name": "SiS-Add (Second Leg Add-on)", "sf\_ref": "SF-11", "slot\_key": "SIS\_ADDON", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M064", "ict\_module\_id": "\#64", "ict\_module\_name": "SMT-Trigger", "sf\_ref": "SF-11", "slot\_key": "SMT\_TRIGGER", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M065", "ict\_module\_id": "\#65", "ict\_module\_name": "PO3-Intra", "sf\_ref": "SF-11", "slot\_key": "PO3\_INTRA", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M066", "ict\_module\_id": "\#66", "ict\_module\_name": "TS-Suite (Turtle Soup Suite)", "sf\_ref": "SF-11", "slot\_key": "TS\_SUITE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M067", "ict\_module\_id": "\#67", "ict\_module\_name": "IDX→Stock-Map", "sf\_ref": "SF-08", "slot\_key": "IDX\_STOCK\_MAP", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M068", "ict\_module\_id": "\#68", "ict\_module\_name": "ETF-Proxy", "sf\_ref": "SF-08", "slot\_key": "ETF\_PROXY", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M069", "ict\_module\_id": "\#69", "ict\_module\_name": "RelStr-SMT", "sf\_ref": "SF-08", "slot\_key": "REL\_SMT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M070", "ict\_module\_id": "\#70", "ict\_module\_name": "Stock-Event", "sf\_ref": "SF-02", "slot\_key": "STOCK\_EVENT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M071", "ict\_module\_id": "\#71", "ict\_module\_name": "MTF-TopDown", "sf\_ref": "SF-08", "slot\_key": "MTF\_TOPDOWN", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M072", "ict\_module\_id": "\#72", "ict\_module\_name": "Trigger-Seq", "sf\_ref": "SF-11", "slot\_key": "TRIGGER\_SEQ", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M073", "ict\_module\_id": "\#73", "ict\_module\_name": "Limit/Market", "sf\_ref": "SF-11", "slot\_key": "ORDER\_TYPE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M074", "ict\_module\_id": "\#74", "ict\_module\_name": "RR-Base", "sf\_ref": "SF-11", "slot\_key": "RR\_BASE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M075", "ict\_module\_id": "\#75", "ict\_module\_name": "Post-Entry-Neg", "sf\_ref": "SF-11", "slot\_key": "POST\_NEG", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M076", "ict\_module\_id": "\#76", "ict\_module\_name": "TP1-IL/FVG", "sf\_ref": "SF-11", "slot\_key": "TP1\_TARGET", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M077", "ict\_module\_id": "\#77", "ict\_module\_name": "TP2-EL", "sf\_ref": "SF-11", "slot\_key": "TP2\_TARGET", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M078", "ict\_module\_id": "\#78", "ict\_module\_name": "Time-Exit", "sf\_ref": "SF-13", "slot\_key": "TIME\_EXIT\_RULE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M079", "ict\_module\_id": "\#79", "ict\_module\_name": "Trail-SL", "sf\_ref": "SF-11", "slot\_key": "TRAIL\_SL", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M080", "ict\_module\_id": "\#80", "ict\_module\_name": "Journal-Std", "sf\_ref": "SF-14", "slot\_key": "JOURNAL\_STD", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M081", "ict\_module\_id": "\#81", "ict\_module\_name": "Event-Tags", "sf\_ref": "SF-14", "slot\_key": "EVENT\_TAGS", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M082", "ict\_module\_id": "\#82", "ict\_module\_name": "Model-KPI", "sf\_ref": "SF-14", "slot\_key": "MODEL\_KPI", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M083", "ict\_module\_id": "\#83", "ict\_module\_name": "R/Hit (R-Multiple×HitRate)", "sf\_ref": "SF-14", "slot\_key": "R\_HIT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M084", "ict\_module\_id": "\#84", "ict\_module\_name": "BL-Update (Blacklist Update)", "sf\_ref": "SF-15", "slot\_key": "BL\_UPDATE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M085", "ict\_module\_id": "\#85", "ict\_module\_name": "08:30-Block", "sf\_ref": "SF-02", "slot\_key": "EMBARGO\_BLOCK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M086", "ict\_module\_id": "\#86", "ict\_module\_name": "NYL-WL (NY Lunch Guard)", "sf\_ref": "SF-12", "slot\_key": "NYL\_GUARD", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M087", "ict\_module\_id": "\#87", "ict\_module\_name": "Fed-Risk", "sf\_ref": "SF-02", "slot\_key": "FED\_RISK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M088", "ict\_module\_id": "\#88", "ict\_module\_name": "ER-Risk (Earnings Risk)", "sf\_ref": "SF-02", "slot\_key": "ER\_RISK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M089", "ict\_module\_id": "\#89", "ict\_module\_name": "CHK-Weekly", "sf\_ref": "SF-01", "slot\_key": "CHK\_WEEKLY", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M090", "ict\_module\_id": "\#90", "ict\_module\_name": "CHK-Daily", "sf\_ref": "SF-02", "slot\_key": "CHK\_DAILY", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M091", "ict\_module\_id": "\#91", "ict\_module\_name": "CHK-Pre", "sf\_ref": "SF-03", "slot\_key": "CHK\_PRE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M092", "ict\_module\_id": "\#92", "ict\_module\_name": "CHK-Entry-3in1", "sf\_ref": "SF-11", "slot\_key": "CHK\_ENTRY", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M093", "ict\_module\_id": "\#93", "ict\_module\_name": "CHK-Lunch", "sf\_ref": "SF-12", "slot\_key": "CHK\_LUNCH", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M094", "ict\_module\_id": "\#94", "ict\_module\_name": "CHK-Close", "sf\_ref": "SF-14", "slot\_key": "CHK\_CLOSE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M095", "ict\_module\_id": "\#95", "ict\_module\_name": "Tri-Map", "sf\_ref": "SF-08", "slot\_key": "TRI\_MAP", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M096", "ict\_module\_id": "\#96", "ict\_module\_name": "SMT-Rel", "sf\_ref": "SF-08", "slot\_key": "SMT\_REL", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M097", "ict\_module\_id": "\#97", "ict\_module\_name": "LQ-Tier", "sf\_ref": "SF-08", "slot\_key": "LQ\_TIER", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M098", "ict\_module\_id": "\#98", "ict\_module\_name": "Event-Lag", "sf\_ref": "SF-08", "slot\_key": "EVENT\_LAG", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M099", "ict\_module\_id": "\#99", "ict\_module\_name": "NWOG/NDOG+CE", "sf\_ref": "SF-03", "slot\_key": "NWOG\_CE", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M100", "ict\_module\_id": "\#100", "ict\_module\_name": "Vacuum Block/Breakaway Gap", "sf\_ref": "SF-11", "slot\_key": "VACUUM\_BLOCK", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M101", "ict\_module\_id": "\#101", "ict\_module\_name": "BPR/RDRB", "sf\_ref": "SF-11", "slot\_key": "BPR\_RDRB", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M102", "ict\_module\_id": "\#102", "ict\_module\_name": "Silver Bullet (SB)", "sf\_ref": "SF-11", "slot\_key": "SILVER\_BULLET", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M103", "ict\_module\_id": "\#103", "ict\_module\_name": "London-Raid", "sf\_ref": "SF-11", "slot\_key": "LONDON\_RAID", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M104", "ict\_module\_id": "\#104", "ict\_module\_name": "CBDR", "sf\_ref": "SF-11", "slot\_key": "CBDR", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M105", "ict\_module\_id": "\#105", "ict\_module\_name": "Inducement", "sf\_ref": "SF-08", "slot\_key": "INDUCEMENT", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M106", "ict\_module\_id": "\#106", "ict\_module\_name": "IPDA", "sf\_ref": "SF-08", "slot\_key": "IPDA", "status": "ACTIVE"},  
    {"entry\_id": "ICT-M107", "ict\_module\_id": "\#107", "ict\_module\_name": "Trader Style Framework", "sf\_ref": "SF-00", "slot\_key": "TRADER\_STYLE", "status": "ACTIVE"}  
  \]  
}

*來源：\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]*

### **A.6 驗證與同步策略 (Validation & Sync Policy)**

* **同步策略 (Sync Strategy)**：  
  * **觸發**：ICT 模組變更、SF 主鍵變更、方法卡定案。  
  * **流程**：偵測變動 → 鎖定 crosswalk.json → 更新 → 一致性檢查 → 提交。  
  * **驗證**：無孤兒引用、無重複 ID、Locator 可回放。  
  * **Fail-Closed**：同步失敗則 BLOCK\_RELEASE，回滾上一版。  
* **每日抽驗 (Daily Audit)**：  
  * **時機**：每日盤前 (08:30-09:00)。  
  * **方法**：隨機抽 10 條，驗證 Locator 可回放性。  
  * **Fail-Closed**：單日失敗 $\\ge$ 3 條觸發 Gate Fail；連續 3 日同一條目失敗則 BLOCK\_RELEASE。  
* **驗收條件 (Acceptance)**：  
  * 記錄數完整 (107)。  
  * 無跳號。  
  * Locator 非空。  
  * SF\_Ref 有效。

---

# **APPX-B. Conflict Ledger (衝突裁決台帳)**

本附錄匯總 Spartoi P1 系統開發過程中，跨文件、跨層級發生的所有規格衝突（Conflicts）及其裁決結果。依據「方案 B」與「權威堆疊（Authority Stack）」原則，所有裁決均以\*\*Fail-Closed（預設阻斷）**為底線，並以**SSOT（單一真相來源）\*\*為最終依歸。此台帳為系統合規性的核心審計依據。  
---

### **B.1 裁決機制與權威堆疊 (Adjudication Mechanism)**

所有衝突必須依據以下「權威順位」進行裁決。若低順位文件與高順位文件衝突，必須修正低順位文件以符合高順位定義。

**Authority Stack (裁決順位)**：

1. **P0-Q\&A\_1114**：最高權威，定義核心閉環與日常任務。  
2. **REQ21 (Spartoi系統21項需求)**：核心硬約束（如 No-API, XQ 唯一下單）。  
3. **RS-B (待補充需求庫)**：補齊 P1 缺口需求。  
4. **StRS+SyRS v5.2.0**：上位需求。  
5. **Spartoi｜P1\_SRS v7.0.0**：軟體需求 SSOT，P1 內部最高裁決者。  
6. **Spartoi｜P1\_ARCH v6.0.0-r5**：架構設計 SSOT（子系統、邊界）。  
7. **Runbook & WI v2.0.0**：操作層實作參照（Implementation SSOT）。  
8. **Legacy Docs / External**：僅作證據（Evidence），不可作為規範（Normative）。

*來源：\[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]*

---

### **B.2 系統級衝突裁決 (System Level Conflicts)**

本節記錄涉及系統架構、子系統邊界與核心定義的重大衝突。此類衝突由 LBP-C(ADR) 與 ARCH 主導裁決。

| Conflict ID | 衝突主題 | 來源 A (舊/低權威) | 來源 B (新/高權威) | 裁決結果 | 裁決理由/依據 | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **CL-002** | **子系統數量** | SIR v5.1.0 (16 CA) | ARCH v6.0.0-r5 (15 CA) | **15 CA** | **刪除 CA-FIREWALL**。功能已併入 CA-GOVERN，避免疊床架屋。 | \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\] |
| **CL-003** | **旗標架構** | SIR v5.1.0 (3 flags) | SRS v7.0.0 (Tier 分層) | **Tier-0/1/2 分層** | 採用分層管理風險：Tier-0 (系統級)、Tier-1 (階段級)、Tier-2 (標的級)。 | \[Spartoi｜P1\_LBP-C(ADR)\_v2.0.1.txt\]\[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **CL-RW-007** | **子系統列表** | 母本 A (14 個) | ARCH v6.0.0 (15 個) | **15 個** | 統一採用 ARCH 定義的 15 個白名單子系統，嚴禁新增第 16 個。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-SIR-001** | **SRS 版本引用** | README v3.0.0 (SRS v6.1.0) | SRS v7.0.0 | **SRS v7.0.0** | SRS v7.0.0 為最新 Baseline，README 需升級。 | \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\] |
| **CL-README-003** | **系統定位** | README v4.0.0 (離線優先) | P0-Q\&A (雲地協作) | **雲地系統** | 依據 P0 最高權威，定位修正為「單人+多AI協作、雲地系統 (LOCAL+WT-NA)、全程聯網」。 | \[Spartoi｜P1\_README\_v4.0.1.md\] |

---

### **B.3 執行與操作層衝突 (Execution & Operations Conflicts)**

本節記錄涉及具體操作流程、時間窗與參數設定的衝突。此類衝突主要發生在 Runbook 與各母本之間。

| Conflict ID | 衝突主題 | 來源 A (母本/舊版) | 來源 B (SRS/Runbook) | 裁決結果 | 裁決理由/依據 | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **CL-RW-001** | **SF 主鍵命名** | OP-nn 格式 | SF-xx 格式 | **SF-xx** | 統一使用 **SF-00\~SF-31**。OP-nn 僅允許出現在 Crosswalk 附錄。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-RW-002** | **週級股數量** | 母本 A (10-30 檔) | P0-Q\&A (15-35 檔) | **15-35 檔** | P0-Q\&A 為最高權威 (A3)。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-RW-003** | **S1 候選數量** | 母本 A (5-8 檔) | SRS v7.0 (6-10 檔) | **6-10 檔** | 依據 SRS 定義。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-RW-004** | **午盤迴避** | 11:00-12:30 | REQ21 \+ 實測 | **11:30-12:00** | 縮短迴避窗口，但允許豁免 (Tier-2 Flag)。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-RW-005** | **反打倉位** | 30% | 母本 B \+ P0 | **50% (0.5x)** | 統一設定為正打倉位的 50%。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-RW-006** | **ROD-only** | 13:20 起始 | SRS v7.0 | **13:25 起始** | 交易所規則為 13:25 進入收盤集合競價。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-RW-009** | **開盤校準窗** | 09:00-09:05 | 母本 B \+ 實測 | **09:00-09:10** | 給予更充裕的 Pattern 識別時間。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-RW-010** | **HITL 簽核** | 5 欄位 | SRS v7.0 §6 | **7 欄位** | 增加 `evidence_ptr` 與 `risk_check` 等必填欄位。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-001** | **強清時間** | A版 (13:20 強清) | SFHB (13:10 禁新倉) | **雙規則並行** | 13:10 禁止建立新倉 (含加碼)，13:20 執行強制平倉。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |
| **CL-003** | **Watch 下單** | 舊版 (入場提醒) | REQ21 (不下單) | **強化不下單** | CA-WATCH 僅負責監控與發出訊號，嚴禁執行下單動作。 | \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\] |

---

### **B.4 需求與規格層衝突 (Requirements & Specs Conflicts)**

本節記錄涉及 SRS、ICD 與 LBP 文件間的規格定義衝突。

| Conflict ID | 衝突主題 | 來源 A (舊/低權威) | 來源 B (新/高權威) | 裁決結果 | 裁決理由/依據 | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **CL-SIR-005** | **ICT 熱插拔** | SIR v6.0.0 (default=true) | Gate 裁決 (Safe Default) | **false** | `ict_hot_swap_enabled` 默認值修正為 **false**，遵循 Safe Default 原則。 | \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\] |
| **CL-SIR-006** | **Gate 定義** | 舊版 (不分層) | Gate 裁決 (Policy/Check) | **分層架構** | Gate 必須分為 **Policy** (裁決層，三態) 與 **Check** (檢核層，gate\_id) 分離。 | \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\] |
| **CONF-001** | **延遲閾值** | P0-Q\&A (未定義) | RS-B (建議 500ms) | **P0 為準** | RS-B 建議值移至 Rationale (non-normative)，SRS 不硬性定義數值。 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **CONF-002** | **風控條文** | StRS (寬鬆) | REQ21 (嚴格) | **REQ21** | 採用 REQ21 的嚴格風控標準。 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **CL-ICD-002** | **ICD 子系統** | ICD v4.0 (16 CA) | ARCH v6.0 (15 CA) | **15 CA** | 更新 ICD 以對齊 ARCH 的 15 子系統定義。 | \[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\] |
| **CL-ICD-003** | **Flag Tier** | ICD v4.0 (無分層) | SRS v7.0 (Tier-0/1/2) | **Tier 分層** | 更新 ICD Schema 以支援 Flag Tiering。 | \[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\] |

---

### **B.5 平台與入口層衝突 (Platform Level Conflicts)**

本節記錄涉及 README、入口點與整體導航的衝突。

| Conflict ID | 衝突主題 | 來源 A (舊版 README) | 來源 B (SRS/Runbook) | 裁決結果 | 裁決理由/依據 | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **CL-README-001** | **錨點引用** | v4.0.0 (SRS-FLAG-GOV) | SRS v7.0.0 | **修正錨點** | 修正為 `SRS#SRS-V700-FLAG-GOVERNANCE` 以符合 SRS 實際錨點。 | \[Spartoi｜P1\_README\_v4.0.1.md\] |
| **CL-README-002** | **外掛入口** | v4.0.0 (宣稱有) | 主表 (未列出) | **新增入口** | v4.0.1 主表新增外掛附件合冊入口列。 | \[Spartoi｜P1\_README\_v4.0.1.md\] |
| **GAP-README-001** | **Multi-LLM** | v3.0.0 (R8 規範) | Playbook | **OPEN** | Multi-LLM 協作規範尚未在 Playbook 中提供等價路由，列為 GAP。 | \[Spartoi｜P1\_README\_v4.0.1.md\] |

---

### **B.6 驗收與稽核規則 (Validation Rules)**

為確保 Conflict Ledger 的權威性與一致性，系統必須執行以下自動化檢核：

1. **Resolved 狀態檢查**：所有標記為 `RESOLVED` 的衝突，其裁決結果必須在當前版本的 SSOT 文件中找到對應的落實（Evidence）。  
2. **CR\_OPEN 關聯**：若裁決結果為「無法裁決」或「待驗證」，必須關聯一個有效的 `CR_OPEN_ID`，並設定 `Fail-Closed` 行為。  
3. **Authority Stack 一致性**：所有裁決理由必須明確引用 Authority Stack 中的權威文件（如 P0, REQ21, SRS），不得引用低權威文件（如 Draft, Memo）作為裁決依據。  
4. **Version Lock**：涉及文件版本衝突時（如 v1.2 vs v2.0），必須明確宣告採用較新版本，並在 `Regression Guard` 中確認無功能倒退。

---

# **APPX-C. CR\_OPEN Register (待決事項清單)**

本附錄是 Spartoi 系統中所有「未經驗證假設」、「待補全規格」與「未授權門檻」的集中登錄地。依據《Spartoi-OMOC\_開發實作方案.md》定義的「Fail-Closed」原則，任何未在正文中定案的規格，**必須** 轉化為 CR\_OPEN 條目，並綁定阻斷性 Gate 政策（BLOCK\_RELEASE / RADAR\_ONLY），嚴禁以模糊的「Candidate」或「TODO」形式殘留在正文中 \[Spartoi-OMOC\_開發實作方案.md\]\[Spartoi｜P1\_SRS\_v7[.0.0.md](http://.0.0.md)\]。  
---

### **C.1 治理與處置規則 (Governance & Disposition)**

本節定義 CR\_OPEN 的生命週期管理與處置原則，確保所有缺口皆處於「受控」狀態。

#### **1\. 遷移規則 (Migration Rule)**

* **強制遷移**：所有原始文件（SRS v6.1, Runbook v1.0 等）中的「Candidate（候選條款）」、「TBD（待定）」或「建議值」，**必須** 全量遷移至本 CR\_OPEN Register。  
* **正文零殘留**：SRS、ARCH、Runbook 的規範性章節（Normative Sections）中，**不得** 出現未經授權的數值門檻（如 `<`、`>`、`≤`、`≥`、`%`）。所有數值必須移至 CR\_OPEN 的 `evidence_refs` 或 `rationale` 區塊 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。

#### **2\. Fail-Closed 預設行為**

每條 CR\_OPEN 必須明確定義在該缺口未關閉前的系統行為，預設採保守策略：

| Gate Policy | 行為定義 | 適用場景 | 來源 |
| ----- | ----- | ----- | ----- |
| **BLOCK\_RELEASE** | **阻斷發布**。CI/CD Pipeline 直接失敗，不得宣稱 P1 完成。 | 缺失關鍵證據、核心功能失敗（如 Win Rate 未達標）、Schema 結構缺失。 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **RADAR\_ONLY** | **僅觀測**。允許運行與產出工件，但禁止進入 EXECUTE 階段。 | 門檻值未驗證、非核心功能缺口、效能指標未達標。 | \[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\] |
| **EXECUTE\_DISABLED** | **禁用執行**。運行期禁用特定高風險動作（如自動下單）。 | Kill Switch 觸發、HITL 未確認、高風險 CR 未關閉。 | \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\] |

#### **3\. 關單標準 (Closure Criteria)**

* **證據門檻**：每條 CR\_OPEN 必須蒐集 **至少 2 筆** 有效證據（Evidence），其中必須包含至少 1 筆來自 P0/Legacy 內部數據，以及 1 筆外部權威來源（External）\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **驗證通過**：必須通過指定的 Validation Plan（如產出 `xxx_report.json` 並通過 Schema 驗證）。

---

### **C.2 登錄結構 (Schema Definition)**

為確保機器可讀性與自動化稽核能力，每條 CR\_OPEN 必須符合以下 JSON Schema 結構 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]\[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。

cr\_open\_entry:  
  cr\_id: "CR-{DOMAIN}-{SEQ}"       \# 唯一識別碼 (如 CR-SRS-001)  
  title: "缺口標題"  
  description: "缺口描述 (Numeric-Free)"  
  owner: "責任子系統或角色"  
  gate\_policy: "BLOCK\_RELEASE | RADAR\_ONLY | EXECUTE\_DISABLED"  
  gate\_id: "GATE-{CATEGORY}-{SEQ}" \# 關聯的 Gate ID  
  evidence\_refs:                   \# 至少 2 筆  
    \- evidence\_id: "EV-{SEQ}"  
      source\_type: "P0 | LEGACY | EXTERNAL"  
      source\_locator: "文件名 \+ anchor"  
      claim\_summary: "證據摘要"  
      suggested\_threshold: "數值建議 (Non-normative)"  
  validation\_plan:                 \# 關單計畫  
    expected\_artifact: "驗證產物名稱"  
    closure\_condition: "關單條件描述"  
  status: "OPEN | VALIDATED | CLOSED"

---

### **C.3 全域待決事項清單 (Global Register)**

本節匯總來自 SRS、ARCH、LBP 系列與 Runbook 的所有 CR\_OPEN 條目。

#### **C.3.1 核心需求與品質缺口 (From SRS & LBP-E)**

*來源：\[Spartoi｜P1\_SRS\_v7.0.0.md\]\[Spartoi｜P1\_LBP-E(Fitness)\_v3.0.1.md\]*

| CR\_ID | 標題 | 缺口描述 | Gate Policy | 關單計畫 |
| ----- | ----- | ----- | ----- | ----- |
| **CR-SRS-001** | **閉環延遲量測** | 系統閉環延遲閾值未獲 SRS 授權 | **BLOCK\_RELEASE** | 產出 `latency_report.json` |
| **CR-SRS-002** | **EQA100 蒸餾品質** | EQA100 指標定義與門檻未定 | **BLOCK\_RELEASE** | 產出 `eqa_report.json` |
| **CR-SRS-003** | **勝率量測** | 勝率 (Win Rate) 最低門檻未定 | **BLOCK\_RELEASE** | 產出 `win_rate_report.json` |
| **CR-SRS-004** | **Sharpe Ratio** | 夏普比率門檻未定 | **RADAR\_ONLY** | 產出 `sharpe_report.json` |
| **CR-SRS-005** | **執行品質** | 執行滑價與填充率門檻未定 | **EXECUTE\_DISABLED** | 產出 `exec_report.json` |
| **CR-SRS-006** | **滑價量測** | 平均滑價容忍值未定 | **RADAR\_ONLY** | 產出 `slip_report.json` |
| **CR-SRS-007** | **最大回撤 (MDD)** | 每日/每週 MDD 限制未定 | **BLOCK\_RELEASE** | 產出 `drawdown_report.json` |
| **CR-SRS-008** | **回測過擬合 (PBO)** | PBO 檢測標準未定 | **BLOCK\_RELEASE** | 產出 `pbo_report.json` |
| **CR-SRS-011** | **TVE 等價驗證** | XS 轉譯等價性分數 (Score) 門檻未定 | **BLOCK\_RELEASE** | 產出 `tve_report.json` |
| **CR-SRS-012** | **Playwright 自動化** | WT-NA 自動化腳本穩定性未驗證 | **RADAR\_ONLY** | 產出 `playwright_report.json` |

#### **C.3.2 架構與介面缺口 (From ARCH & ICD)**

*來源：\[Spartoi｜P1\_ARCH\_v6.0.0-r5.md\]\[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]*

| CR\_ID | 標題 | 缺口描述 | Gate Policy | 關單計畫 |
| ----- | ----- | ----- | ----- | ----- |
| **CR-ICD-003** | **Agent Schema** | Agent 工件 (Session/Trace) Schema 細節未定 | **EXECUTE\_DISABLED** | 定義 `SCHEMA-AGENT-*` |
| **CR-ICD-004** | **T1 Overnight Ledger** | 隔日沖留倉帳本 Schema 未定 | **RADAR\_ONLY** | 定義 `SCHEMA-T1-*` |
| **CR-ICD-005** | **MarketProfile** | 台股微結構參數完整欄位未定 | **RADAR\_ONLY** | 定義 `SCHEMA-MARKETPROFILE` |
| **CR-ICD-007** | **Arbiter Decision** | 多模型仲裁決策 Schema 未定 | **RADAR\_ONLY** | 定義 `SCHEMA-ARBITER-*` |
| **CR-ARCH-001** | **Flag 擴充授權** | Flag Registry 擴充欄位權限未定 | **RADAR\_ONLY** | 更新 Flag Registry |
| **CR-ARCH-002** | **Agent Guardrails** | Agent 越權行為的具體攔截規則未定 | **RADAR\_ONLY** | 定義 Guardrails Policy |

#### **C.3.3 操作與參數缺口 (From Runbook)**

*來源：\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]*

| CR\_ID | 標題 | 缺口描述 | Gate Policy | 關單計畫 |
| ----- | ----- | ----- | ----- | ----- |
| **CR-RW-001** | **Script Score 門檻** | S1 候選池篩選分數未授權 (舊版 75\) | **BLOCK\_RELEASE** | Fitness 回測確認 |
| **CR-RW-002** | **R:R 具體數值** | 風險報酬比門檻未授權 (舊版 1:2.5) | **BLOCK\_RELEASE** | Fitness 回測確認 |
| **CR-RW-003** | **風險配額數值** | 單筆交易風險佔比未授權 (舊版 0.3-0.6%) | **BLOCK\_RELEASE** | 風險模型驗證 |
| **CR-RW-004** | **週級股數量** | 週選股清單數量範圍未授權 (舊版 15-35) | **BLOCK\_RELEASE** | 統計驗證 |
| **CR-RW-006** | **XS/XSAT 能力邊界** | XS 語法自動化能力未經官方文件確認 | **RADAR\_ONLY** | 取得官方文件驗證 |
| **CR-RW-007** | **XQ 自動操盤能力** | XQ 付費模組自動化能力未經實測 | **RADAR\_ONLY** | 實盤模擬測試 |
| **CR-RW-008** | **Data 延遲閾值** | 即時行情延遲容忍值未定 (500ms/1s) | **BLOCK\_RELEASE** | 實測統計 |

#### **C.3.4 控制平面缺口 (From Control Plane)**

*來源：\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]*

| CR\_ID | 標題 | 缺口描述 | Gate Policy | 關單計畫 |
| ----- | ----- | ----- | ----- | ----- |
| **CR-CP-001** | **CLI Exit Code** | CLI 退出碼語義未經上游定義 | **TEMP-CLOSED** | 驗證 exit\_code 行為 |
| **CR-CP-002** | **CLI 介面規格** | Orchestrate CLI 參數未完整定義 | **TEMP-CLOSED** | 驗證 CLI 參數解析 |
| **CR-CP-003** | **Cowork API 監控** | 針對 API 上傳的具體監控腳本未定 | **TEMP-CLOSED** | 驗證 grep 偵測規則 |
| **CR-CP-004** | **Input Sanitization** | L3 輸入清洗的具體腳本未定 | **TEMP-CLOSED** | 驗證 Sanitizer 輸出 |
| **CR-CP-005** | **Ops Cowork 例外** | Ops 模式下啟用 Cowork 的審批流程未定 | **REMAINS-OPEN** | 定義例外授權流程 |

---

### **C.4 關單與稽核流程 (Closure & Audit)**

所有 CR\_OPEN 的狀態變更必須遵循以下流程：

1. **提交證據**：針對特定 CR\_ID 提交 `closure_proposal.json`，包含所需的 Evidence Refs 與 Validation Report。  
2. **Gate 驗證**：GateRunner 執行對應的 Gate (如 `GATE-RL-003`)，檢查是否滿足關單條件。  
3. **狀態更新**：  
   * 驗證通過 $\\to$ 更新狀態為 `CLOSED` 或 `VALIDATED`。  
   * 驗證失敗 $\\to$ 狀態維持 `OPEN`，並觸發對應的 Fail-Closed 行為 (BLOCK/RADAR)。  
4. **審計記錄**：所有狀態變更寫入 `cr_open_audit_log.jsonl`，確保可追溯。

---

# **APPX-D. Gate Templates (8 Gate 詳細規格)**

本附錄定義 Spartoi 系統中 **不可協商的 8 組標準 Gate 模板**。依據《Spartoi-OMOC\_開發實作方案.md》與「方案 B」的自動化原則，這些模板是控制平面（Control Plane）實施「Fail-Closed（預設阻斷）」與「Layer-1 機械裁決」的唯一依據。系統嚴禁新增第 9 個 Gate 模板，所有驗證邏輯必須歸類於此 8 類之中。  
---

### **D.1 模板結構契約 (Template Structure Contract)**

所有 Gate 模板文件（`G-*.template.yaml`）必須位於 `/gates/templates/` 目錄下，並嚴格遵循以下欄位定義 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]\[Spartoi｜MVP Spine / Walking Skeleton Pack v0\_最小實作包v1.3.0.md\]。

| 欄位名稱 (Field) | 必填 | 說明與約束 | 來源 |
| ----- | ----- | ----- | ----- |
| **gate\_id** | YES | 格式 `G-{TYPE}`，必須為 8 個標準 ID 之一。 | \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\] |
| **gate\_name** | YES | 人類可讀名稱（如：來源完整性 Gate）。 | \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\] |
| **gate\_class** | YES | 歸屬的 G5 分類（G5-A \~ G5-G）。 | \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\] |
| **scope** | YES | 適用範圍（Spine / 子系統 / 工件類型）。 | \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\] |
| **inputs** | YES | 驗證所需的輸入工件清單。 | \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\] |
| **judgment\_logic** | YES | 判定邏輯的文字描述（供 Audit 使用）。 | \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\] |
| **evidence\_schema** | YES | 驗證後產出的證據資料結構定義。 | \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\] |
| **pass\_criteria** | YES | 機械可執行的通過條件（Expression）。 | \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\] |
| **fail\_action** | YES | 失敗時的處置：`BLOCK_RELEASE` / `RADAR_ONLY` / `EXECUTE_DISABLED`。 | \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\] |
| **owner** | YES | 負責人角色（HITL / Reviewer-LLM / Auto）。 | \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\] |

---

### **D.2 8 大標準 Gate 規格 (The 8 Standard Gates)**

本節詳述 8 個標準 Gate 的邏輯與行為。任何子系統的驗收需求，均須映射至以下模板之一 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

#### **1\. G-SRC：來源完整性 Gate (Source Integrity)**

* **Gate Class**: **G5-A** (Source/Spec Integrity)  
* **核心職責**: 確保「No-Source-No-Norm」。驗證所有輸入與產出皆有明確的來源追溯，防止幻覺或無中生有。  
* **Judgment Logic**:  
  * 檢查 inputs\_manifest 是否存在且完整。  
  * 驗證所有規範引用（citation\_chain）是否可解析至上游 SSOT。  
  * 檢查必填欄位是否存在。  
* **Evidence Schema**: `{source_doc, hash, version, citation_chain}`  
* **Pass Criteria**: `所有必填欄位存在` AND `引用鏈可解析`。  
* **Fail-Closed Action**: **BLOCK\_RELEASE**（阻斷發布）。來源不明的產物視為污染，絕對禁止進入下游 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

#### **2\. G-SCHEMA：Schema 合規 Gate (Schema Compliance)**

* **Gate Class**: **G5-C** (Artifact Contract & Schema)  
* **核心職責**: 確保產出的 JSON/YAML 結構符合 ICD 定義，防止格式漂移。  
* **Judgment Logic**:  
  * 執行 JSON Schema 校驗。  
  * 強制檢查 `additionalProperties: false`（禁止未定義欄位）。  
* **Evidence Schema**: `{schema_version, validation_result, errors[]}`  
* **Pass Criteria**: `validation_result == PASS` AND `errors.length == 0`。  
* **Fail-Closed Action**: **BLOCK\_RELEASE**（阻斷下游）。格式錯誤的檔案無法被自動化工具處理 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

#### **3\. G-BT-H：回測健康度 Gate (Backtest Health)**

* **Gate Class**: **G5-G** (Performance & TCA)  
* **核心職責**: 驗證回測的有效性，防止過擬合（Overfitting）與前視偏差（Look-ahead Bias）。  
* **Judgment Logic**:  
  * 確認 backtest\_report.json 存在。  
  * 檢查是否包含前視偏差檢測（Look-ahead Check）。  
  * 檢查是否有訓練集/測試集洩漏（Leakage Check）。  
* **Evidence Schema**: `{backtest_id, sample_period, lookahead_check, leakage_check}`  
* **Pass Criteria**: `lookahead_check == PASS` AND `leakage_check == PASS`。  
* **Fail-Closed Action**: **CONDITIONAL**（記錄但標記警告）。若失敗，標記為高風險策略，需人工複審 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

#### **4\. G-SEG-L：語意保真 Gate (Semantic Fidelity)**

* **Gate Class**: **G5-E** (LLM Output Quality)  
* **核心職責**: 驗證蒸餾或轉譯過程中的語義是否失真（Drift）。  
* **Judgment Logic**:  
  * 使用 Golden Set（黃金樣本集）進行抽樣比對。  
  * 檢測是否存在關鍵矛盾（Contradiction）或遺漏。  
* **Evidence Schema**: `{golden_set_id, sample_count, match_rate, contradiction_list}`  
* **Pass Criteria**: `contradiction_list.length == 0`（零矛盾）。  
* **Fail-Closed Action**: **FAIL \+ Record Drift Log**。失敗時阻斷該批次，並將差異寫入 Drift Log 供模型調優 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜P1\_LBP-E(Fitness)\_v3.0.1.md\]。

#### **5\. G-CONF-L：信賴度 Gate (Confidence/Coverage)**

* **Gate Class**: **G5-E** (LLM Output Quality)  
* **核心職責**: 確保模型輸出的信賴度與覆蓋率達標。  
* **Judgment Logic**:  
  * 檢查準確度（Accuracy）是否高於閾值。  
  * 檢查樣本量（Sample Size）是否滿足最小要求（N\_min）。  
* **Evidence Schema**: `{accuracy, sample_n, confidence_interval}`  
* **Pass Criteria**: `accuracy >= threshold` AND `sample_n >= N_min`。  
* **Fail-Closed Action**: **CONDITIONAL**。若未達標，記錄並標記 CR\_OPEN，允許繼續但需人工關注 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。

#### **6\. G-XQ-PARITY：XQ 一致性 Gate (XQ Parity)**

* **Gate Class**: **G5-F** (Execution & Observability)  
* **核心職責**: 確保本地生成的 XS 腳本在 XQ 平台上的行為與預期一致（TVE 驗證）。  
* **Judgment Logic**:  
  * XS 腳本是否可編譯（Compile Check）。  
  * 訊號一致性（Signal Parity）是否 \>= 95%。  
  * 模擬交易（Paper Trading）結果比對。  
* **Evidence Schema**: `{compile_status, signal_parity_score, paper_trade_result}`  
* **Pass Criteria**: `compile_status == SUCCESS` AND `signal_parity_score >= 0.95`。  
* **Fail-Closed Action**: **BLOCK\_RELEASE**（阻斷發布）。腳本錯誤可能導致交易災難，絕對禁止上線 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md\]。

#### **7\. G-HITL-LOG：HITL 日誌 Gate (Human-In-The-Loop Log)**

* **Gate Class**: **G5-D** (Safety & Fail-Closed)  
* **核心職責**: 強制執行「人工確認」機制，確保高風險操作有人類背書。  
* **Judgment Logic**:  
  * 檢查 `hitl_handoff.json` 是否存在。  
  * 驗證是否包含有效的人工確認紀錄（Operator ID, Timestamp, Decision）。  
* **Evidence Schema**: `{hitl_ts, operator_id, confirm_status, decision_reason}`  
* **Pass Criteria**: `confirm_status IN (APPROVED, REJECTED)`。  
* **Fail-Closed Action**: **BLOCK\_RELEASE**。無人工確認紀錄的指令，嚴禁進入執行階段 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

#### **8\. G-RUN：可執行 Gate (Runnable)**

* **Gate Class**: **G5-F** (Execution & Observability)  
* **核心職責**: 驗證交付物在標準環境下是否可「一鍵跑通」。  
* **Judgment Logic**:  
  * 執行 Entrypoint 腳本，檢查 Exit Code。  
  * 驗證執行環境指紋（Env Fingerprint）是否一致。  
  * 確認是否符合 No-Paid-API 基線。  
* **Evidence Schema**: `{run_id, env_fingerprint, execution_time, exit_code}`  
* **Pass Criteria**: `exit_code == 0` AND `env_fingerprint matches`。  
* **Fail-Closed Action**: **BLOCK\_RELEASE**。無法執行的程式碼沒有交付價值 \[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

---

### **D.3 工程落地結構 (Engineering Implementation)**

本節定義上述 Gate 模板在專案目錄中的實體位置與執行方式 \[Spartoi｜MVP Spine / Walking Skeleton Pack v0\_最小實作包v1.3.0.md\]。

* **目錄位置**: `/gates/templates/`  
* **檔案清單**:  
  * `G-SRC.template.json`  
  * `G-SCHEMA.template.json`  
  * `G-BT-H.template.json`  
  * `G-SEG-L.template.json`  
  * `G-CONF-L.template.json`  
  * `G-XQ-PARITY.template.json`  
  * `G-HITL-LOG.template.json`  
  * `G-RUN.template.json`  
* **執行器**: `GateRunner` (位於 `/gates/runner/gate_runner.py`) 負責讀取上述模板，比對 `manifest.json` 與 `artifacts/`，並產出 `gate_report.json`。

---

# APPX-E. Web Evidence Index (外部證據索引)

本附錄彙整 Spartoi 系統開發過程中引用的所有外部網路證據（Web Evidence）。依據《Spartoi｜P1\_LBP-A(SIR)\_v6.0.0-r2.md》與《Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md》之規範，本附錄內容屬於 **Non-normative（非規範性）** 參考資料，僅供風險雷達（Risk Radar）與技術決策佐證使用。若需將其中的主張（Claims）升格為系統規範（Normative），必須透過 **CR\_OPEN** 機制進行登記與驗證，嚴禁直接引用作為驗收標準。  
---

### **E.1 證據可信度評級規則 (Credibility Rating Rules)**

為確保外部資訊引用的嚴謹性，所有 Web Evidence 必須依據以下規則進行分級。此分級決定了該證據能支撐何種程度的決策。

| 等級 (Grade) | 定義 (Definition) | 適用條件 (Criteria) | 決策效力 (Effect) |
| ----- | ----- | ----- | ----- |
| **A** | **官方/一手/可重現 (Official/Primary/Reproducible)** | 來自官方文件（如 Anthropic/GitHub Docs）、業界標準組織（NIST/OWASP）、或具備完整 POC 步驟的可重現研究（如 PromptArmor）。 | **可支撐 CR\_OPEN**：可作為風險判定、架構設計的主要依據。 |
| **B** | **媒體/二手報導 (Media/Secondary)** | 知名科技媒體報導（如 TechCrunch/The Verge），但缺乏獨立技術驗證細節。 | **需交叉驗證**：不可單獨作為阻斷（Block）依據，需配合 A 級證據使用。 |
| **C** | **不可驗證/論壇 (Unverified/Forum)** | 單一來源、論壇評論、個人部落格，且無法交叉驗證者。 | **僅供參考**：僅作為背景資訊，**嚴禁**用於支撐任何系統規範。 |

**來源追溯**：

* 評級規則定義：\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。  
* Fail-Closed 應用：\[Spartoi｜P1\_SRS\_v7.0.0.md\]。

### **E.2 Web Evidence Registry (證據註冊表)**

本表彙整與 Spartoi 架構（Agentic Workflow、Cowork、Security）高度相關的關鍵外部證據。

#### **E.2.1 Agentic Workflow & Tooling (WE-CW/SK/CC)**

| Evidence ID | 標題 / 主張摘要 | 發布者 | 日期 | 評級 | 啟示與風險 (Non-normative) | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **WE-CW-001** | **First impressions of Claude Cowork**Cowork 在 VZVirtualMachine 沙盒內執行，處於 Research Preview 狀態。 | Simon Willison | 2026-01-12 | **A** | 沙盒隔離機制可參考；Prompt Injection 風險仍存在，需限制 Cowork 僅能存取單一資料夾。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-CW-002** | **Anthropic launches Cowork**Cowork 約 1.5 週用 Claude Code 建置；macOS only；快速開發可能安全不足。 | Fortune | 2026-01-13 | **B** | 快速迭代可能隱含測試覆蓋率不足，系統需建立更嚴謹的 Gate 防線。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-CW-003** | **Claude Cowork file managing AI agent**資料夾權限模型依賴用戶設定。 | TechCrunch | 2026-01-12 | **B** | 需實作資料夾白名單機制，防止 Agent 越權存取。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-SK-001** | **Equipping agents with Agent Skills**Skills 採漸進式披露 (progressive disclosure)，每 skill 約消耗 50 tokens。 | Anthropic Eng | 2025-10-16 | **A** | Skills 載入策略需最佳化，避免 Context Window 爆炸。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-SK-002** | **Agent Skills \- Claude Docs**Skills 僅限信任來源；惡意 Skill 可導致資料外洩。 | Anthropic Docs | 2026-01-19 | **A** | **第三方 Skills 風險極高**。系統僅允許使用自建或官方白名單 Skills。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-CC-001** | **Claude Code: Best practices**建議 `CLAUDE.md` 自動載入；推行 TDD \+ Staging \+ PR 工作流。 | Anthropic Eng | 2025-04-18 | **A** | Handoff 應只靠 PR/Tag/Release，避免宣告式完成。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-CC-002** | **Building agents with the Claude Agent SDK**SDK 給予電腦存取權；需建立 Gather \-\> Action \-\> Verify 迴圈。 | Anthropic Eng | 2026-01 | **A** | 需建立 Fail-Closed 機制，控制平面驗證迴圈至關重要。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |

#### **E.2.2 Security & Risks (WE-CW-SEC/OW)**

| Evidence ID | 標題 / 主張摘要 | 發布者 | 日期 | 評級 | 啟示與風險 (Non-normative) | 來源 |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **WE-CW-SEC-001** | **Claude Cowork Exfiltrates Files**(POC) `api.anthropic.com` 白名單可被利用上傳檔案至攻擊者帳戶。 | PromptArmor | 2026-01-15 | **A** | **高風險**：間接 Prompt Injection。建議監控並阻斷非預期的 API 上傳行為。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-CW-SEC-002** | **Exfiltration risk resurfaces**Anthropic 承認但未修補；非技術用戶難以偵測。 | The Register | 2026-01-15 | **A** | Prompt Injection 已確認為實質風險。控制平面需將此風險轉化為可檢查的 Stopline。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-CW-SEC-003** | **Critical Security Flaw in Cowork**攻擊對 Haiku/Opus 4.5 皆生效，模型升級無法防禦。 | TechPlanet | 2026-01-16 | **B** | **架構性防禦比模型能力重要**。不可依賴模型「變聰明」來解決安全問題。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-CW-SEC-004** | **Non-Zero Attack Risk Warning**私資料 \+ 不信任內容 \+ 外部通訊 \= 致命三要素。 | byteiota | 2026-01-16 | **B** | 必須實施 **Input Trust Tier** 機制。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-OW-001** | **OWASP Top 10 for LLM Applications 2025**Prompt Injection 為首要風險；Excessive Agency 為新增風險。 | OWASP | 2025-11 | **A** | 結構性問題無完美解，必須有 Input Trust Tier \+ Stopline \+ Two-phase 確認。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |
| **WE-OW-002** | **OWASP Top 10 for Agentic Applications**Agentic 系統引入新失敗模式：Tool Misuse, Data Leakage。 | OWASP GenAI | 2025-12-10 | **A** | **LLM 安全 ≠ Agentic 安全**。需制定針對 Agent 的特定安全策略。 | \[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\] |

#### **E.2.3 SRS Domain Evidence (EV-\*)**

以下證據直接支撐 SRS v7.0.0 中的 CR\_OPEN 門檻設定。

| Evidence ID | 主張摘要 | 來源類別 | SRS 對應 | 來源 |
| ----- | ----- | ----- | ----- | ----- |
| **EV-LAT-002** | **台股當沖延遲基準研究**建議延遲閾值 ≤ 200ms。 | EXTERNAL | SRS-NFR-LAT-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-EQA-002** | **GPT-Eval 品質評估論文**定義 EQA (Extraction Quality Assessment) 指標框架。 | EXTERNAL | SRS-SQM-EQA-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-WIN-002** | **台股當沖勝率統計研究**市場統計數據，支撐 P0 成功定義。 | EXTERNAL | SRS-SQM-S3-WIN-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-SHARPE-002** | **Sharpe Ratio 原始論文**Sharpe Ratio 定義與計算標準。 | EXTERNAL | SRS-SQM-S3-SHARPE-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-EXEC-002** | **執行品質量測研究**定義滑價與執行落差的量測方法。 | EXTERNAL | SRS-SQM-S6-EXEC-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-DD-003** | **MDD 研究論文**最大回撤 (Max Drawdown) 的風險評估標準。 | EXTERNAL | SRS-SQM-S7-DD-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-PBO-002** | **Bailey PBO 論文**Probability of Backtest Overfitting (PBO) 計算方法。 | EXTERNAL | SRS-SQM-PBO-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-TVE-002** | **TVE 方法論文獻**Translation-Validation Equivalence 的驗證理論基礎。 | EXTERNAL | SRS-FR-TVE-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |
| **EV-PLAY-002** | **Playwright 官方文檔**瀏覽器自動化工具的技術規格。 | EXTERNAL | SRS-FR-PLAYWRIGHT-001 | \[Spartoi｜P1\_SRS\_v7.0.0.md\] |

### **E.3 URL Registry (連結註冊表)**

為防止連結失效（Link Rot），所有 URL 必須在此集中管理，並定期驗證有效性。

| Evidence ID | URL |
| ----- | ----- |
| **WE-CW-001** | `https://simonwillison.net/2026/Jan/12/claude-cowork/` |
| **WE-CW-003** | `https://techcrunch.com/2026/01/12/anthropic-launches-cowork/` |
| **WE-CW-SEC-001** | `https://www.promptarmor.com/resources/claude-cowork-exfiltrates-files` |
| **WE-CW-SEC-002** | `https://www.theregister.com/2026/01/15/anthropics_claude_bug_cowork/` |
| **WE-SK-001** | `https://spring.io/blog/2026/01/13/agent-skills-progressive-disclosure` |
| **WE-OW-001** | `https://owasp.org/www-project-top-10-for-large-language-model-applications/` |
| **WE-007 (SLSA)** | `https://slsa.dev/` |
| **WE-009 (SRE)** | `https://sre.google/sre-book/` |
| **WE-012 (METR)** | `https://metr.org/blog/2025-01-ai-productivity-study/` |
| **WE-013 (Copilot)** | `https://arxiv.org/abs/2302.07884` |

**來源追溯**：

* URL 列表來源：\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]。

### **E.4 衝突與交叉驗證 (Conflict & Cross-Validation)**

當外部證據之間存在矛盾時，依據以下邏輯進行裁決，並記錄於 Conflict Ledger。

| 風險 / 議題 | 來源 1 | 來源 2 | 是否矛盾 | 結論與處置 |
| ----- | ----- | ----- | ----- | ----- |
| **Files API 外洩風險** | PromptArmor (POC) \[A\] | The Register (報導) \[B\] | 否 | **風險已確認**。Anthropic 計劃更新 VM 限制，但在修補前需實施嚴格的 Input Trust Tier 與白名單機制。 |
| **Prompt Injection** | OWASP \[A\] | Simon Willison \[A\] | 否 | **無完美解決方案**。架構設計必須假設 Agent 會被混淆，故控制平面（Control Plane）必須由 Deterministic Code 執行，不得依賴 LLM 自行判斷。 |
| **Cowork 訂閱要求** | REPORT-B (僅 Max) \[C\] | Anthropic 官網 (含 Pro) \[A\] | **是** | **依官網為準**。確認 2026-01-16 起擴展至 Pro 訂閱。 |
| **效率增益數值** | REPORT-B (30-60%) \[C\] | REPORT-C (85%) \[C\] | **是** | **皆為 Unverified**。數據僅供參考，相關門檻值登記為 CR\_OPEN-015，不納入 Normative 規範。 |

**來源追溯**：

* 衝突分析：\[Spartoi｜SubP1-LITE+MVP\_總控控制平面\_v1.0.1.md\]\[Spartoi｜SubP1-LITE+MVP\_藍圖v1.2.2.md\]。

---

# **APPX-F. Route-Out Register (跨文件路由表)**

本附錄是 Spartoi 系統中防止「雙重維護（Dual Maintenance）」與「規格漂移（Spec Drift）」的核心治理機制。依據「方案 B」的 SSOT 原則，本表強制規定所有未在本文件中定義的細節，必須明確指向唯一的上游權威來源（Upstream Authority），嚴禁在多處重複定義。  
---

### **F.1 Route-Out 治理原則 (Governance Principles)**

* **單一真相來源 (SSOT)**：任何規格僅能在一個地方定義（Normative），其他地方只能引用（Reference）。若發現正文重寫了上游規則，視為治理違規 \[Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI\_v1.4.0.md\]。  
* **最小可定位性 (Minimal Locatability)**：所有 Route-Out 必須包含 `Document ID`、`Anchor/Section` 與 `Description`，確保機器與人類皆可精確跳轉，禁止模糊引用（如「詳見架構文件」）\[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。  
* **Fail-Closed 驗證**：若 Route-Out 指向的錨點不存在或版本不匹配，視為斷鏈，Gate 必須 **BLOCK\_RELEASE** \[Spartoi｜P1\_SRS\_v7.0.0.md\]。

### **F.2 Route-Out 清單 (The Register)**

本表全量登錄系統中所有「外導」項目，確保每一項實作細節皆有源可溯。

| Route-Out ID | 事項描述 (Description) | 上游文件 (Upstream Doc) | 上游錨點 (Anchor) | 本文引用處 | 狀態 (Status) |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **RO-001** | **T1 隔日沖完整規則** | **MethodCard (T1)** | `[T1-METHODCARD]` | §2.2 | **PENDING** |
| **RO-002** | **ICT 模組詳細教義** | **CA-METHOD 產出** | `[CA-METHOD-ICT]` | §7.1 | **PENDING** |
| **RO-003** | **script\_score v2 權重** | **SRS v7.0.0** | `[SRS-SCRIPT-SCORE-V2]` | §10.2 (CR-006) | **CR\_OPEN** |
| **RO-004** | **R:R (風險報酬比) 門檻驗證** | **SRS v7.0.0** | `[SRS-RR-RATIO]` | §10.2 (CR-002) | **CR\_OPEN** |
| **RO-005** | **風險配額定義** | **SRS v7.0.0** | `[SRS-RISK-QUOTA]` | §10.2 (CR-003) | **CR\_OPEN** |
| **RO-006** | **JobCard 完整 Schema** | **LBP-B (ICD)** | `[ICD-JOBCARD-SCHEMA]` | §4 | **ROUTE\_OUT** |
| **RO-007** | **產物欄位完整契約** | **LBP-B (ICD)** | `[ICD-ARTIFACT-SCHEMA]` | §5 | **ROUTE\_OUT** |
| **RO-008** | **Gate 執行器實作** | **ARCH v6.0.0** | `[ARCH-GATE-EXECUTOR]` | §6.1 | **ROUTE\_OUT** |
| **RO-009** | **子系統間通訊協議** | **ARCH v6.0.0** | `[ARCH-INTEROP]` | §1.3 | **ROUTE\_OUT** |
| **RO-010** | **Crosswalk 衝突裁決理由** | **LBP-C (ADR)** | `[ADR-CROSSWALK-PRIORITY]` | 附錄 B | **ROUTE\_OUT** |
| **RO-011** | **T0/T1 產物隔離決策** | **LBP-C (ADR)** | `[ADR-T0T1-ISOLATION]` | §5.6 | **PENDING** |
| **RO-012** | **Tests Catalog 完整腳本** | **LBP-E (Fitness)** | `[FITNESS-TESTS]` | 附錄 D | **ROUTE\_OUT** |
| **RO-013** | **台股時段最新制度驗證** | **External (TWSE)** | \- | §3.4 | **PENDING** |
| **RO-014** | **NWOG/NDOG 台股化定義** | **CA-METHOD** | `[CA-METHOD-NWOG-TW]` | Pending-001 | **PENDING** |
| **RO-015** | **台股事件旗標清單** | **SRS v7.0.0** | `[SRS-EVENT-FLAGS-TW]` | Pending-003 | **PENDING** |

*來源依據：\[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]*

### **F.3 狀態說明 (Status Definitions)**

為了精確管理每一個 Route-Out 項目的生命週期，系統定義了以下三種狀態：

* **ROUTE\_OUT**：

  * **定義**：明確指向已存在的上游 SSOT（如 SRS, ARCH, ICD）。  
  * **行動**：本文件僅作索引，讀者應跳轉至上游閱讀細節。  
  * **驗證**：GateRunner 需驗證目標錨點是否存在 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。  
* **CR\_OPEN**：

  * **定義**：上游規範尚未定案或數值未驗證，已在 CR\_OPEN Register 中登記。  
  * **行動**：暫時採用保守的 Fail-Closed 策略（如 BLOCK\_RELEASE 或 RADAR\_ONLY），等待上游補齊 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
* **PENDING**：

  * **定義**：依賴於尚未產出的文件（如特定 MethodCard 或外部 API 文件）。  
  * **行動**：在本文件中列為「待決項目（Pending Item）」，並在執行時進行標記或降級處理 \[Spartoi｜台股當沖隔日沖\_RUNBOOK\&WI\_v2.0.0.md\]。

### **F.4 驗收與稽核 (Verification & Audit)**

本附錄的完整性與正確性由以下 Gate 進行機械化驗收：

1. **GATE-RL-004 (Drift Check)**：  
   * 掃描所有 Route-Out 的 `Upstream Anchor`。若目標文件更新導致錨點失效，Gate 回報 **FAIL** 並阻斷發布 \[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
2. **SRS-GOV-ROUTEOUT-001**：  
   * 驗證 Route-Out 目標是否僅限於 README、ARCH、LBP 系列文件，禁止指向非規範性文件（如草稿、聊天記錄）\[Spartoi｜P1\_SRS\_v7.0.0.md\]。  
3. **ICD-TOKEN-EXISTENCE**：  
   * 若 Route-Out 指向 ICD Schema，必須驗證該 Token 在 ICD 中真實存在 \[Spartoi｜P1\_LBP-B(ICD)\_v5.0.1.md\]。

---

**END**

