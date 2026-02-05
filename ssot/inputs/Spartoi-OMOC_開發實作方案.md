## **0\) 封面卡（任務摘要）**

**日期：2026-02-04（Asia/Taipei）**  
你要的不是「把文件改寫成 opencode 版本」，而是：**用 opencode \+ Oh My OpenCode（OMOC）把 Spartoi 全域需求「工程化落地 \+ 自動驗收」**，並且嚴禁造輪子。  
**主要結論一句話：你選的方案 B（單一流水線 \+ CA\_ID 參數化 \+ GitHub reusable workflows/composite actions）是「最短工期、最低人工」的正解；但你對「直接做完整版」的疑慮是合理的——原 SSOT 明確把高風險運行期（尤其 EXECUTE）鎖在 HITL/禁用與 P1/P2 分工邊界，所以「完整版」必須拆成：（A）全量控制面+驗收閉環落地（可宣稱完成）** \+ **（B）運行期工程化（P2+，需 Route-Out/CR\_OPEN 管控，否則等於造輪子）**。

---

## **1\) 需求對齊（目標 / 約束 / 指定資料）**

### **你的最終目標**

1. **強制採用** opencode \+ Oh My OpenCode 作為多代理新架構。([opencode.ai](https://opencode.ai/docs/cli/?utm_source=chatgpt.com))  
2. **把 Spartoi 全部需求與功能改用現成高評價工具/開源落地**（可微改；一旦特化就必須警告「造輪子風險」）。  
3. **一口氣完成：設計開發 → 落地實作 → 驗收**，而且要能覆蓋你上傳的所有 SSOT（SRS/ARCH/藍圖/RUNBOOK/台股流程母本等）。

### **硬性約束（會直接決定「能不能叫完整版」）**

* **P1/P2 邊界是硬規則**：P1 只做「合約與證據鏈」，P2 才做「工程化實作與部署」。  
* \*\*Gate polSE / RADAR\_ONLY / EXECUTE\_DISABLED），不允許偷加第四態；而且需求條文必須同時有 gate\_policy \+ gate\_id。  
* \*\*XQ（唯一下單端指令文件/證據，禁止偷換成自動下單；資金操作必須人工確認。  
* 你選的方案 B 技workflow / composite action\*\*（這就是「不造輪子」的關鍵槓桿）。([GitHub Docs](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows?utm_source=chatgpt.com))

### **指定資料（本回合已對齊到的關鍵錨點）**

* Spartoi 系統架構指南：CR\_OPEN 必須有 Validation Plan \+ Closure Condition，沒關單就 Fail-Closed。  
* SubP1-LITE+MVP 藍圖：把交付拆成可跑薄切片，其他 Route-Out；且明確要求 HITL、安全拓撲、工具導入邊界。-GMA Lite 實作指南：主張「先跑流水線骨架」與 v0 Trinity（Control Plane Spec / Runbook / ) 研究摘要（子題發現 \+ 可驗證引文）

我把問題拆成 6 個可驗證子題；每題只給能落地的結論。

### **子題 A：opencode / OMOC 能不能當 Spartoiencode 提供 GitHub agent 安裝與在 Actions 內執行的路徑（`opencode github install`、`opencode github run`），適合做「控制面先行」。([opencode.ai](https://opencode.ai/docs/cli/?utm_source=chatgpt.com))**

* OMOC 作為 OpenCode 插件，主打「agent harness」與多代理編排（規劃/查找/架構/背景 agent 等），很契合你要的「低人工、自動化」。([GitHub](https://github.com/code-yeongyu/oh-my-opencode?utm_source=chatgpt.com))

### **子題 B：方案 B 的關鍵技術（CA\_ID 參數化 \+ 重用工作流/組合 action）是不是最短工期？**

* **是**：GitHub 官方就提供 **reusable workflows（workflow\_call）** 用 inputs/secrets 做參數化；**composite action** 用來封裝重複步驟。兩者疊加，就是你要的「拆成可重複套用模組」。([GitHub Docs](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows?utm_source=chatgpt.com))

### **子題 C：為什麼你「直接做完整版」會踩坑？**

* 因為你的 SSOT 已經把「完整版」拆成分層：  
  * SRS 明訂 P1/P2 分工；P1 不含部署/運行期代碼，P2 才接 CI/CD 阻斷等工程化。  
  * 藍圖明訂「XQ 唯一下單端 \+ HITL」，禁止自動下單。  
    \=\> 所以「一口氣完成完整版」**只有兩種合法定義**：  
1. **完整版（控制面+驗收閉環完整）**：可宣稱完成，EXECUTE 仍可被 Kill-Switch/HITL 鎖住。  
2. **完整版（含運行期工程化自動交易）**：直接違反你自己的硬規則（HITL/XQ 限制）或必須改憲（高風險、近乎必然造輪子）。

### **子題 D/ merge queue / rulesets」不讓你又卡住？**

* Grkflow 也支援 `merge_group` 事件，否則 required check 不會被回報，併入會失敗。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))  
* required stat之類的實務坑，必須用 schedule/週期性跑一次避免狀態消失。([GitHub Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/troubleshooting-required-status-checks?utm_source=chatgpt.com))  
* rulesets 的 規則是官方標準能力。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets?utm_source=chatgpt.com))

### **子題 E：你要求的 DocOps（MkDocs \+ Pages \+ link/style lint）能不能全用現成輪子？**

* 可以：Material for MkDocs 官方提供 GitHub Actions 部署範本；MkDocs 官方也有部署指南。([squidfunk.github.io](https://squidfunk.github.io/mkdocs-material/publishing-your-site/?utm_source=chatgpt.com))  
* link check / prose lint / mega lint 都有成熟 action：Lychee、Vale、MegaLinter。([GitHub](https://github.com/lycheeverse/lychee-action?utm_source=chatgpt.com))

### **子題 F：供應鏈安全與證據（你要的「可稽核」）怎麼做才不造輪子？**

* OpenSSF Scorecard 有官方 GitHub Action；GitHub 也有 artifact attestations（build provenance），都屬現成輪子。([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))  
* 但要注意：Scorecard 對私有 repo 的支援條件、artifact attestations 對私有 repo 的方案等級限制（這會影響你是否能「一口氣全上」）。([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))

---

## **3\) 完整方案（可直接照做的「最佳開發實作路線」）**

方向：**控制面先行 \+ 流水線骨架先跑 \+ 文檔 delta/自動產物回填**。  
核心策略：**不改你原本 P1 憲法（SRS/ARCH），而是在其上加一層 P2「Spartoi-OMOC 控制面」**，用方案 B 把所有 CA 子系統變成可參數化的「工作站」。

### **3.1 架構與流程（ASCII）**

                  ┌─────────────────────────────────────────┐  
                   │   P1 SSOT（不動）：SRS / ARCH / LBP / ...│  
                   │   \- Gate policy 三態 / P1-P2 邊界 / HITL │  
                   └─────────────────────────────────────────┘  
                                     ▲  
                                     │ trace / gate\_id / evidence hooks  
                                     │  
┌────────────────────────────────────────────────────────────────────────┐  
│ P2 控制面：Spartoi-OMOC-GMA Lite（新增，不覆寫P1）                      │  
│  \- opencode github agent \+ OMOC plugin                                  │  
│  \- 單一流水線（matrix）+ CA\_ID 參數化                                   │  
│  \- reusable workflows \+ composite actions                               │  
│  \- required checks / merge queue / rulesets / attest / scorecard        │  
└────────────────────────────────────────────────────────────────────────┘  
                 │                      │  
                 │ calls(workflow\_call) │  
                 ▼                      ▼  
        ┌────────────────┐     ┌────────────────┐    ...（CA stations）  
        │ CA\_STATION(WRC) │     │ CA\_STATION(TA)  │  
        │ inputs→outputs  │     │ inputs→outputs  │  
        │ evidence+verdict│     │ evidence+verdict│  
        └────────────────┘     └────────────────┘  
                 │                      │  
                 └───────────┬──────────┘  
                             ▼  
                   ┌──────────────────┐  
                   │ GateRunner \+ Index│  
                   │ pass/fail \+ packs │  
                   └──────────────────┘

### **3.2 你要先落地 OMOC-GMA Lite 嗎？**

**結論：不用「先把 OMOC 文件全落地」才動工；要反過來。**  
理由：OMOC 指南本身就主張 v0 Trinity \+ TvS 先跑，避免「文檔寫完就過期」。  
**最佳路線是：先把 P2 控制面骨架跑起來（讓 required checks 先穩），再用骨架自動產物回填 delta 文檔。**

### **3.3 方案 B 的落地藍圖（一步到位，覆蓋全部 CA）**

#### **(I) 先定「控制面最小不變量」＝所有 CA 共用的 I/O 合約**

用 OMOC v0 Trinity 的精神，直接把每個 CA 工作站統一成這三份產物（**不造輪子：沿用你 SSOT 的 manifest/evidence/verdict 風格**）：

* `inputs_manifest.json`：本次 CA 的輸入（資料版本、策略版本、參數、模式 RADAR\_ONLY/EXECUTE\_DISABLED）  
* `evidence_manifest.json`：本次輸出的證據索引（log、報告、圖表、指令文件、trace\_map）  
* `verdict.json`：gate\_id 結果（對齊 SRS 的 gate\_policy 三態）

\*\*造輪子警告（特化點）：\*\*如果你想讓每個 CA 都有完全不同的輸入輸出格式，短期看起來「更像完整版」，實際上就是把可重用性砍掉，直接走向客製地獄。

#### **(II) 單一流水線：`pipeline.yml` 用 matrix 一次跑完 15 CA**

* `matrix.ca_id: [CA-WRC, CA-CORPUS, ... CA-GOVERN]`  
* 每個 job 只做三件事：  
  1. 讀取 `ca/<CA_ID>/station.config.(yml|json)`  
  2. 執行 `ca_station`（reusable workflow）  
  3. 上傳 artifact（evidence pack）+ 回報 required check

#### **(III) 把重工封裝：reusable workflows \+ composite actions**

* `reusable workflow`：負責「一整個 CA 工作站」的 job 邏輯（含環境、cache、產物上傳、狀態回報）。([GitHub Docs](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows?utm_source=chatgpt.com))  
* `composite action`：封裝「setup runtime、拉 opencode/OMOC、跑 gate runner、整理 packs。([GitHub Docs](https://docs.github.com/actions/creating-actions/creating-a-composite-action?utm_source=chatgpt.com))

#### **(IV) required checks / merge queue / rulesets：一次做對，避免你再卡住**

* 所有 workflow trigger 必須同時包含：`pull_request`、`push`、**`merge_group`**（配合 merge queue）。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))cks 建議固定成少數穩定名稱（例如 `docops-gatekit` / `ca-pipeline` / `security-scorecard`），減少 rulesets 漂移。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets?utm_source=chatgpt.com))  
* 加一個週期性 `schedule` 跑「最小檢核」，避免 required checks 因為太久沒跑而失效/消失。([GitHub Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/troubleshooting-required-status-checks?utm_source=chatgpt.com))

#### **全套現成輪子（不造輪子清單）**

* Docs：MkDocs Material \+ GitHub Pages（官方範本路徑）。([squidfunk.github.io](https://squidfunk.github.io/mkdocs-material/publishing-your-site/?utm_source=chatgpt.com))  
* Lint：MegaLinter（官方安裝指引）([megalinter.io](https://megalinter.io/v8/install-github/?utm_source=chatgpt.com))  
* Link：Lychee action([GitHub](https://github.com/lycheeverse/lychee-action?utm_source=chatgpt.com))  
* Prose：Vale action([GitHub](https://github.com/errata-ai/vale-action?utm_source=chatgpt.com))  
* Supply chain：OpenSSF Scorecard action([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))  
* Provenance：GitHub artifact attestations（attest-build-provenance）([GitHub Docs](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds?utm_source=chatgpt.com))

\*\*現實限制提醒（別踩雷）：\*\*artifact attestations 對私有 repo 的可用性與方案等級有硬限制；Scorecard 對私有 repo 也有條件（例如需要 GitHub Advanced Security）。這些不是你技術不行，是方案條款。([GitHub](https://github.com/actions/attest-build-provenance?utm_source=chatgpt.com))

### **3.4 「全量完成」的正確定義（讓你能宣稱完成、又不違規）**

你問：「能不能直接完成完整版，而非 MVP？」——可以，但必須先定義「完整版」的驗收口徑，否則一定自爆：

#### **✅ 可宣稱「完整版完成」的口徑（建議採用）**

**完整版＝控制面（P2）工程化 \+ 全 CA 工作站可跑 \+ 全驗收閉環 PASS \+ 高風險 EXECUTE 仍受 HITL/kill-switch/政策鎖定**。  
這完全符合你 SSOT 的：

* P1/P2 分工（P2 做工程化）  
* Gate policy 三態（可把未關單/未達門檻留在 RADAR\_ONLY/EXECUTE\_DISABLED）  
* CR\_OPEN 必須有 Validation Plan、沒關單就 Fail-Closed（不讓未證實的東西進高風險路徑）

#### **❌ 高風險、幾乎等於造輪子的口徑（強烈警告）**

「完整版＝自動下單、自動資金操作」：這直接撞上你藍圖硬規則（XQ 唯一下單端 \+ HITL）。除非你願意改憲法，否則不成立。

---

## **4\) 風險與對策（技術 / 資料 / 法規 / 營運）**

### **4.1 技術風險**

1. **工作流狀態檢查不回報 / merge queue 失敗**  
* 偵測：PR 進 merge queue 後 required checks 缺失  
* 緩解：workflow 加 `merge_group` 事件([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))  
* 備援：暫停 merge queue，改用一般 required checks 合流  
2. **required checks 因太久沒跑而失效**  
* 偵測：rulesets 顯示「找不到狀態檢查」或無法設為 required  
* 緩解：加 schedule 週期跑最小檢核([GitHub Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/troubleshooting-required-status-checks?utm_source=chatgpt.com))  
* 備援：用固定名稱的「空跑」workflow 維持狀態  
3. **供應鏈功能（attest/scorecard）在私有 repo 不可用**  
* 偵測：action 權限/方案限制報錯  
* 緩解：先在 public repo 跑通；私有 repo 走「替代證據」(SBOM \+ 簽章外掛)  
* 備援：先把 attest/scorecard 降級為 RADAR\_ONLY（不阻斷主線）  
  ([GitHub](https://github.com/actions/attest-build-provenance?utm_source=chatgpt.com))

### **4.2 資料風險**

* 偵測：台股數據來源授權不明、回測樣本不足  
* 緩解：全部不確定資料走 CR\_OPEN，附 Validation Plan 與關單條件（勝率/DSR/樣本等）  
* 備援：在 RADAR\_ONLY 模式產工件，不進 EXECUTE

### **4.3 法規/合規風險（尤其「交易」）**

* 偵測：任何「自動下單」或繞過人工確認的路徑出現  
* 緩解：把 EXECUTE 鎖在 HITL；只輸出「指令文件/證據」給 XQ 手動執行  
* 備援：kill-switch（EXECUTE\_DISABLED）一鍵降級

### **4.4 營運風險（低人工反而可能變成「看不懂就放著燒」）**

* 偵測：agent 背景任務堆積、成本不可控、結果不可稽核  
* 緩解：強制 evidence\_manifest \+ verdict \+ trace\_map；任何缺證據＝BLOCK\_RELEASE  
* 備援：把耗時/高 token 任務改成「離線批次 \+ 人工抽查」的 RADAR\_ONLY

---

## **5\) 來源索引（去重 ≥ 8；含支撐章節）**

下面每條都能直接支撐你「不造輪子」的落地決策（括號為主要支撐章節）。

1. OpenCode Docs — Install / CLI（§2A, §3）([opencode.ai](https://opencode.ai/docs/?utm_source=chatgpt.com))  
2. Oh My OpenCode GitHub repo / docs（§2A, §3）([GitHub](https://github.com/code-yeongyu/oh-my-opencode?utm_source=chatgpt.com))  
3. GitHub Docs — Reuse workflows（workflow\_call）（§2B, §3）([GitHub Docs](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows?utm_source=chatgpt.com))  
4. GitHub Docs — Creating a composite action（§2B, §3）([GitHub Docs](https://docs.github.com/actions/creating-actions/creating-a-composite-action?utm_source=chatgpt.com))  
5. GitHub Docs — Managing a merge queue（merge\_group）（§2D, §3.3）([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))  
6. GitHub Docs — Availaks（§2D, §3.3）([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets?utm_source=chatgpt.com))OpenSSF §3.3）([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))  
7. GitHubatform"\] Docs — Artifact attestations \+ attest-build-provenance（§2F, §3.3, §4）([GitHub Docs](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds?utm_source=chatgpt.com))search8  
8. MegaLinter official install guide（§2E, §3.3）([megalinter.io](https://megalinter.io/v8/install-github/?utm_source=chatgpt.com))  
9. Lychee action \+ Vale action（§2E, §3.3）([GitHub](https://github.com/lycheeverse/lychee-action?utm_source=chatgpt.com))  
10. Material for MkDocs publishing (GitHub Actions) \+ MkDocs deploy docs（§2E, §3.3）([squidfunk.github.io](https://squidfunk.github.io/mkdocs-material/publishing-your-site/?utm_source=chatgpt.com))

---

## **6\) 附錄：驗收檢核表（你要的「可驗證」門檻）**

你要「完整版」不被質疑，就用下面這份當 DoD。

### **A. 流水線與治理（必過）**

* Rulesets：required checks 已設好且名稱穩定([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets?utm_source=chatgpt.com))  
* workflows 支援 `pull_request` \+ `push` \+ `merge_group`([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))  
* 每個 CA job 都產出：inputs\_manifest / evidence\_manifest / verdict（缺一＝BLOCK\_RELEASE）

### **B. 安全與供應鏈（可分級，不強迫一次到頂）**

* Scorecard 可跑（private repo 若不符條件則降級 RADAR\_ONLY）([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))  
* Attestations 可跑（若 private repo 方案受限則降級）([GitHub](https://github.com/actions/attest-build-provenance?utm_source=chatgpt.com))

### **C. 交易風險（不可破壞的紅線）**

* 所有 EXECUTE 路徑默認 HITL / EXECUTE\_DISABLED，不得自動下單  
* CR\_OPEN 全有 Validation on；未關單不得升級到高風險路徑

---

### **最後一句（務實但不客氣）**

你要「一口氣完成完整版」沒有問題，但**你必須接受：完整版的正確定義是「控制面工程化 \+ 全 CA 可跑可驗收」而不是「自動下單」**。否則你不是在升級架構，是在自己推翻自己的硬規則，然後開始造輪子——而那通常是專案死亡最有效率的方法。

