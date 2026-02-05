# **Spartoi-OMOC啟用子代理-方案 v2**

## **Document Inventory（文件盤點表｜腦內索引）**

**Fail-Closed 原則**：找不到＝不引用；改用更高權威文件頂替；仍不足則列入「假設帳本」。

| DocID | 檔名 / 路徑 | 版本/日期 | 權威層級 | 與本任務關聯（1–2 行） |
| ----- | ----- | ----- | ----- | ----- |
| SSOT-SRS | `/mnt/data/Spartoi｜P1_SRS_v7.0.0.md` | v7.0.0 | **SSOT/SRS** | HITL/Kill-Switch、安全紅線、旗標/風險策略的最高需求來源。 |
| SSOT-ARCH | `/mnt/data/Spartoi｜P1_ARCH_v6.0.0-r5.md` | v6.0.0-r5 | **SSOT/ARCH** | CA/CA-GOVERN/CA-EXECUTE 邊界與「外部副作用隔離」的架構約束。 |
| SSOT-ICD | `/mnt/data/Spartoi｜P1_LBP-B(ICD)_v5.0.1.md` | v5.0.1 | **SSOT/ICD** | 子系統契約、介面與可機械驗收的契約形狀。 |
| SSOT-SIR | `/mnt/data/Spartoi｜P1_LBP-A(SIR)_v6.0.0-r2.md` | v6.0.0-r2 | **SSOT/SIR** | 系統整體稽核、Preflight 與治理要求（含「不確定→降級」的共通規則）。 |
| SSOT-ADR | `/mnt/data/Spartoi｜P1_LBP-C(ADR)_v2.0.1.txt` | v2.0.1 | **SSOT/ADR** | 重要決策紀錄與替代方案裁決規則（No-Source-No-Norm）。 |
| SSOT-ControlPlane | `/mnt/data/Spartoi｜SubP1-LITE+MVP_總控控制平面_v1.0.1.md` | v1.0.1 | **SSOT/Control Plane** | Rulesets/Merge Queue/Required Checks、GateRunner/GateKit 的治理地基。 |
| SSOT-RUNBOOK | `/mnt/data/Spartoi｜SubP1-LITE+MVP 開發 RUNBOOK & WI_v1.4.0.md` | v1.4.0 | **SSOT/RUNBOOK** | Evidence Bundle（三件套：manifest/gate\_report/evidence\_index）、Schema 驗證與機械裁決流程。 |
| PLAN-Dev | `/mnt/data/Spartoi-OMOC_開發實作方案.md` | 未標（檔案內含 2026-02-xx 內容） | **Plan** | 「不造輪子」落地策略、CI/控制面/驗收閉環的計畫書。 |
| PLAN-Exec | `/mnt/data/Spartoi-OMOC 工程實作指南.md` | 未標 | **Plan（嚴格對齊）** | Codespaces 落地流程、操作路徑、驗收與證據留存的主指令。 |
| UPG-OpenClaw | `/mnt/data/OpenClaw x Spartoi-OMOC 升級方案 v2.md` | v2 | **方案/Upgrade** | OpenClaw 只能放「外圍層」：MCP allowlist \+ sandbox \+ 掃描證據 \+ Fail-Closed。 |
| NOTES-BEA | `/mnt/data/Building Effective Agents指南_筆記.txt` | Notes | Notes | Chef/Deputy/Experts、延遲拒絕、Artifact 傳遞、評估/驗證的可復用模式。 |
| NOTES-ClaudeCode | `/mnt/data/Claude Code 卓越編程配置全攻略_筆記.txt` | Notes | Notes | 代碼代理工作法：先探勘再動手、最小 diff、測試/驗證、紀律化工具使用。 |
| NOTES-Compound | `/mnt/data/複利工程指南_筆記.txt` | Notes | Notes | 複利工程：並行隔離、收益遞減停損、可回放證據、worktree/迭代閉環。 |
| NOTES-NEType | `/mnt/data/NE Type Profile 插件-多 Agent 執行方案.txt` | Notes | Notes | 多 Agent 執行分工、QC 閾值、上下文爆炸防線、工具上限。 |
| V1-EnableSubAgents | `/mnt/data/Spartoi-OMOC啟用子代理-方案.md` | v1（舊版） | **被取代** | 既有子代理方案；v2 必須 100% 覆蓋並可完全取代。 |
| REF-ArchGuide | `/mnt/data/Spartoi 系統架構指南.md` | 未標 | Reference | 子系統與治理語彙、設計意圖、名詞一致性校準。 |
| REF-WalkSkeleton | `/mnt/data/Spartoi｜MVP Spine _ Walking Skeleton Pack v0_v1.2.0.md` | v1.2.0 | Reference | 最小實作骨架、端到端打通方式（不新增框架）。 |
| Missing | `《Spartoi GateKit》單獨文件` | — | Missing | **頂替**：以 SSOT-RUNBOOK（GateKit 章節/Schema/三件套）與 SSOT-ControlPlane 覆蓋。 |

---

## **0\) 封面卡（≤120字）**

摘要：以 **OpenCode+OMOC** 為骨架、**Spartoi 控制面**為主權，啟用 **Chef/Deputy/Experts** 子代理；預設最小權限、禁遞迴生子、**MCP 外圍鎖＋HITL/Kill-Switch**；全程產出可機械驗收 Evidence、Trace Map、Delta 與來源索引。

---

## **1\) 目錄（TOC）**

* [2\) 導讀](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#2-%E5%B0%8E%E8%AE%8012-%E5%88%86%E9%90%98%E7%9C%8B%E5%AE%8C%E4%BD%A0%E5%B0%B1%E7%9F%A5%E9%81%93%E6%80%8E%E9%BA%BC%E7%94%A8%E4%BD%A0%E7%8F%BE%E5%9C%A8%E8%A9%B2%E5%81%9A%E5%93%AA%E4%B8%89%E4%BB%B6%E4%BA%8B)  
* [3\) 權威堆疊與裁決規則](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#3-%E6%AC%8A%E5%A8%81%E5%A0%86%E7%96%8A%E8%88%87%E8%A3%81%E6%B1%BA%E8%A6%8F%E5%89%87authority-stack--conflict-rule)  
* [4\) 需求對齊](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#4-%E9%9C%80%E6%B1%82%E5%B0%8D%E9%BD%8A%E7%9B%AE%E6%A8%99%E4%B8%8D%E5%8F%AF%E9%81%95%E5%8F%8D%E6%88%90%E5%8A%9F%E5%AE%9A%E7%BE%A9-dod)  
* [5\) 研究摘要](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#5-%E7%A0%94%E7%A9%B6%E6%91%98%E8%A6%81%E5%90%ABv1-%E7%BC%BA%E5%8F%A35-%E4%BB%BD%E7%AD%86%E8%A8%98%E6%96%B9%E6%A1%88%E5%8F%AF%E5%BE%A9%E7%94%A8%E6%8F%90%E5%8F%96%E7%89%A92026-%E5%A4%96%E9%83%A8%E5%B7%AE%E5%88%86)  
* [6\) 完整方案（可執行）](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#6-%E5%AE%8C%E6%95%B4%E6%96%B9%E6%A1%88%E5%8F%AF%E5%9F%B7%E8%A1%8C)  
  * [6.1 架構與流程](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#61-%E6%9E%B6%E6%A7%8B%E8%88%87%E6%B5%81%E7%A8%8Bascii%E5%BA%8F%E5%88%97%E5%9C%96%E7%9A%86%E5%8F%AF)  
  * [6.2 子代理編排](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#62-%E5%AD%90%E4%BB%A3%E7%90%86%E7%B7%A8%E6%8E%92chefdeputyexpertsartifact-%E5%82%B3%E9%81%9Eqc-%E9%96%BE%E5%80%BC%E5%BB%B6%E9%81%B2%E6%8B%92%E7%B5%95)  
  * [6.3 安全與權限](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#63-%E5%AE%89%E5%85%A8%E8%88%87%E6%AC%8A%E9%99%90permission-matrixallowlistmcp-%E5%A4%96%E5%9C%8D%E9%8E%96hitlkill-switch)  
  * [6.4 模型分流與成本策略](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#64-%E6%A8%A1%E5%9E%8B%E5%88%86%E6%B5%81%E8%88%87%E6%88%90%E6%9C%AC%E7%AD%96%E7%95%A5%E9%A0%90%E8%A8%AD%E7%B5%84%E5%90%88%E5%8D%87%E7%B4%9A%E6%A2%9D%E4%BB%B6%E9%A2%A8%E9%9A%AA)  
  * [6.5 證據與驗收閉環](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#65-%E8%AD%89%E6%93%9A%E8%88%87%E9%A9%97%E6%94%B6%E9%96%89%E7%92%B0evidence-bundlegaterunnerschemapolicy-gatesfail-closed)  
  * [6.6 Coverage Map（C0–C5）](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#66-coverage-mapc0c5%E5%8F%AF%E5%88%A4%E5%AE%9A%E6%A2%9D%E6%AC%BE%E5%A6%82%E4%BD%95%E8%87%AA%E5%8B%95%E7%94%A2%E8%A1%A8)  
  * [6.7 No-Go List](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#67-no-go-list%E6%98%8E%E7%A2%BA%E7%A6%81%E6%AD%A2%E4%BA%8B%E9%A0%85%E6%9B%BF%E4%BB%A3%E5%81%9A%E6%B3%95)  
* [7\) 風險與對策](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#7-%E9%A2%A8%E9%9A%AA%E8%88%87%E5%B0%8D%E7%AD%96%E5%81%B5%E6%B8%AC%E7%B7%A9%E8%A7%A3%E5%82%99%E6%8F%B4%E5%90%AB-mcp%E4%BE%9B%E6%87%89%E9%8F%88tos%E8%B3%87%E5%AE%89)  
* [8\) 遷移指南（v1→v2）](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#8-%E9%81%B7%E7%A7%BB%E6%8C%87%E5%8D%97v1v2%E6%9C%80%E5%B0%8F%E6%AD%A5%E9%A9%9F%E5%9B%9E%E6%BB%BE%E7%AD%96%E7%95%A5)  
* [9\) Trace Map](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#9-trace-mapv1v2-%E7%AB%A0%E7%AF%80%E6%98%A0%E5%B0%84%E8%A1%A8spartoi-%E6%A2%9D%E6%AC%BE%E5%B0%8D%E6%87%89%E8%A1%A8)  
* [10\) RAG/檢索設計](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#10-rag%E6%AA%A2%E7%B4%A2%E8%A8%AD%E8%A8%88rag-header-%E8%A6%8F%E7%AF%84chunk-%E8%A6%8F%E5%89%87rag-triad-%E6%B8%AC%E6%B3%95)  
* [11\) 假設帳本＋衝突帳本＋Delta Log](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#11-%E5%81%87%E8%A8%AD%E5%B8%B3%E6%9C%ACassumption-ledger--%E8%A1%9D%E7%AA%81%E5%B8%B3%E6%9C%ACconflict-ledger--delta-log%E5%A4%96%E9%83%A8%E5%B7%AE%E5%88%86)  
* [12\) 來源索引＋URL Registry](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#12-%E4%BE%86%E6%BA%90%E7%B4%A2%E5%BC%958%E5%8E%BB%E9%87%8D%E6%AF%8F%E7%AD%86%E5%90%AB%E7%AB%99%E9%BB%9E%E6%97%A5%E6%9C%9F%E6%94%AF%E6%92%90%E7%AB%A0%E7%AF%80%E5%8F%A6%E5%90%AB-url-registry)  
* [附錄A) 設定檔範本](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#%E9%99%84%E9%8C%84a-%E8%A8%AD%E5%AE%9A%E6%AA%94%E7%AF%84%E6%9C%ACopencodejson--opencode--omoc-%E9%85%8D%E7%BD%AE)  
* [附錄B) 一鍵驗證命令](https://chatgpt.com/g/g-p-695916a6bb548191a05b2c5f80933397-spartoi-3/c/69847cad-8794-83a5-ac0c-1f85b4b36a82#%E9%99%84%E9%8C%84b-%E4%B8%80%E9%8D%B5%E9%A9%97%E8%AD%89%E5%91%BD%E4%BB%A4%E5%A6%82%E4%BD%95%E9%87%98%E6%AD%BB%E5%AD%90%E4%BB%A3%E7%90%86%E6%9C%89%E8%B7%91%E6%A8%A1%E5%9E%8B%E6%B2%92%E9%A3%84bashwrite-%E4%BB%8D%E8%A2%AB%E6%93%8Bevidence-%E7%94%A2%E7%89%A9%E9%BD%8A%E5%85%A8)

---

## **2\) 導讀（1–2 分鐘看完你就知道怎麼用）＋“你現在該做哪三件事”**

RAG:  
  intent: 快速讓你把「子代理」在 Spartoi-OMOC 裡安全啟用，且可驗收、可回放、可裁決。  
  scope: OpenCode+OMOC 子代理（Chef/Deputy/Experts）、最小權限、MCP 外圍鎖、Evidence/Gates、模型分流。  
  lane: Ops \+ Dev-Implement  
  authority: \[SSOT-SRS, SSOT-ARCH, SSOT-ICD, SSOT-ControlPlane, SSOT-RUNBOOK, PLAN-Dev, PLAN-Exec\]  
  keywords: \[Chef, Deputy, Experts, least-privilege, deny-by-default, MCP allowlist, HITL, Kill-Switch, Evidence Bundle\]  
  anchors: \[6.2, 6.3, 6.5, 6.6, 8, 9\]

### **你會得到什麼（可驗證的那種）**

* **子代理真的有跑**：可從 OpenCode/OMOC logs \+ Evidence Bundle 釘死（不是靠「我覺得它跑了」）。  
* **模型不飄**：預設模型與每個 Agent 的模型策略被鎖死（含升級條件），並可被 grep/Schema 驗收。  
* **權限不漏**：bash/write/mcp 預設 Fail-Closed（ask/deny），且有 allowlist；外部副作用必經 HITL/Kill-Switch。

### **你現在該做哪三件事**

1. **把 v2 設定檔落地**：套用本文件附錄A 的 `opencode.json` \+ `.opencode/*`（先最小權限、後逐步放行）。  
2. **跑一次「驗收命令」**：照附錄B 一鍵跑，產生 Evidence Bundle（三件套 \+ 掃描 \+ gate verdict）。  
3. **把 Rulesets / Required Checks 釘死**：CI 必須包含 `merge_group` 事件，否則 Merge Queue 會把你踢出隊列（GitHub 官方明說）。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue))

---

## **3\) 權威堆疊與裁決規則（Authority Stack & Conflict Rule）**

RAG:  
  intent: 把「誰說了算」鎖死，避免 Notes/網文凌駕 SSOT。  
  scope: 衝突裁決、引用降級、Fail-Closed 行為。  
  lane: Ops  
  authority: \[SSOT-SRS, SSOT-ARCH, SSOT-ICD, SSOT-ControlPlane, SSOT-RUNBOOK\]  
  keywords: \[Authority Stack, Conflict Ledger, No-Source-No-Norm, Fail-Closed\]  
  anchors: \[11\]

### **Authority Stack（由高到低）**

1. **SSOT：SRS \> ARCH \> ICD \> ControlPlane \> RUNBOOK**  
2. **Plan：Spartoi-OMOC\_開發實作方案 / 工程實作指南**（不得與 SSOT 衝突）  
3. **Upgrade/Notes**：OpenClaw 升級方案、五份筆記、社群討論  
4. **Web Sources**：官方文件 \> Maintainer GitHub \> CVE/GHSA/權威通報 \> 嚴肅評測 \> 社群

### **Conflict Rule（裁決）**

* **可變動事實（版本/行為/漏洞/政策）**：必須 **≥2 高品質來源**交叉驗證；衝突則進 Conflict Ledger，依「新近度/一致性/信源品質」裁決。  
* **無來源**：一律降級為假說（Assumption Ledger）＋給最小風險預設（Fail-Closed）。

---

## **4\) 需求對齊（目標/不可違反/成功定義 DoD）**

RAG:  
  intent: 把成功定義寫成可機械判定的 DoD。  
  scope: 子代理治理、權限、MCP、Evidence、Rulesets/Required Checks。  
  lane: Ops \+ Dev-Implement  
  authority: \[SSOT-SRS, SSOT-ARCH, SSOT-ControlPlane, SSOT-RUNBOOK, PLAN-Dev, PLAN-Exec\]  
  keywords: \[DoD, Required Checks, Evidence Bundle, HITL, Kill-Switch\]  
  anchors: \[6.5, 6.6\]

### **目標（Must）**

* 啟用 **Chef/Deputy/Experts** 子代理：**只能主代理呼叫子代理**；工人代理不得遞迴生子。  
* **不造輪子**：只用/改現成工具（OpenCode/OMOC、GitHub Rulesets/Merge Queue、既有 GateRunner/Schema）。  
* **安全紅線**：嚴禁自動下單/無人值守資金操作；所有外部副作用必經 HITL/Kill-Switch（預設 Fail-Closed）。

### **不可違反（Must-Not）**

* 自製 orchestrator / 自造 Gate 框架 → **FAIL**（僅允許 glue/config/小腳本吐真相）。  
* 預設允許 bash/write/mcp → **FAIL**（必須 deny/ask \+ allowlist）。

### **成功定義（DoD｜可機械裁決）**

* **D0**：`opencode.json` / `.opencode/*` 存在且符合策略（Schema/grep 驗證）。  
* **D1**：子代理呼叫記錄存在，且無遞迴生子（log/grep 規則）。  
* **D2**：bash/write/mcp 測試用例被 ask/deny（Fail-Closed）且可重現。([OpenCode](https://opencode.ai/docs/permissions/))  
* **D3**：Evidence Bundle 產出（三件套 \+ 掃描 \+ gate verdict）且 Schema 驗證 PASS（RUNBOOK 的 `spartoi-schema`/ajv）。  
* **D4**：GitHub Rulesets/Required Checks/Merge Queue 正常工作，workflow 含 `merge_group` 觸發。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue))

---

## **5\) 研究摘要（含：v1 缺口、可復用提取物、2026 外部差分）**

RAG:  
  intent: 把「舊版缺口」與「可復用輪子」講清楚，並寫入差分。  
  scope: v1 條款表、提取物分類、Web Delta。  
  lane: Design-Spec \+ Ops  
  authority: \[PLAN-Dev, PLAN-Exec, SSOT-RUNBOOK\]  
  keywords: \[Extraction, Delta Log, Trace Map\]  
  anchors: \[9, 11\]

### **5.1 v1 缺口（為何必須 v2）**

v1 已經提出「鎖預設模型」「防遞迴」「最小權限」「Evidence 驗收」的方向，但仍有三個致命缺口（以 Fail-Closed 視角）：

1. **權威堆疊未充分“上鎖”**：v1 對 SSOT（SRS/ARCH/ICD/RUNBOOK）引用不足，導致條款遇到衝突時容易被 Notes/網文帶偏。  
2. **MCP 外圍層落地不足**：v1 有提 allowlist/sandbox，但缺少「可驗證」的掃描證據與固定驗收條款（CVE/供應鏈風險必須落到證據）。  
3. **RAG/檢索設計未制度化**：v1 沒有強制 chunk 規則、RAG header、RAG-Triad 測法 → 之後被 AI 檢索執行時更容易漏條款、擴權或“自作主張”。

### **5.2 從 5 份筆記/方案提取「可直接用的輪子」**

只提取「可落地到設定檔/工作流/Runbook」的內容；不可落地者降級為原則。

**(a) 多代理編排模式（Chef/Deputy/Experts）**

* Chef：統籌任務、拆解、分派、收斂、決策（但不得直接觸發外部副作用）。  
* Deputy：把關權限/證據/驗收，負責「延遲拒絕」與「Fail-Closed 裁決」。  
* Experts：安全/供應鏈/規格/測試/文件等專長代理，輸出可回放 Artifact（含證據指標與檔路徑）。

**(b) 代碼/代理工作法**

* 先探勘再動手、最小 diff、每步可驗證、只在證據足夠時前進（否則降級為假說）。  
* 工具數量上限、避免上下文爆炸、必要時切 chunk/切 lane。

**(c) 複利工程**

* worktree/隔離並行、迭代閉環、收益遞減停損（例如連續 3 次迭代增益 \<5% 就停）。  
* 任何“看起來很努力”的無效搜尋，直接觸發剎車條款（見 6.2/6.7）。

**(d) OpenClaw 三技巧吸收（但鎖在外圍）**

* workspace 隔離、模型分流、任務後掃描；且 MCP 一律以 allowlist \+ sandbox \+ 掃描證據固化。

**(e) Spartoi GateKit / Evidence / HITL**

* Evidence Bundle 三件套 \+ Schema 驗證 \+ GateRunner 機械裁決；外部副作用必須 HITL 決策包。

### **5.3 Web Delta（2026-02-05 外部差分｜只收會影響落地者）**

* **OpenCode Permissions 已是“細粒度規則”且採「last match wins」**，並支援 `allow/ask/deny`；這使「deny-by-default \+ 精準放行」可用，但也意味著順序寫錯就直接穿洞。([OpenCode](https://opencode.ai/docs/permissions/))  
* **OpenCode Agents 支援 agent-level permissions / task permissions**（可用來限制工人代理工具權限與“遞迴生子”風險）。([OpenCode](https://opencode.ai/docs/permissions/))  
* **OpenCode MCP Servers 有官方配置面**：MCP 會把第三方工具/資源帶進上下文，若不做 allowlist/隔離，屬於“把供應鏈妖風直接開門迎進來”。([OpenCode](https://opencode.ai/docs/mcp-servers/))  
* **GitHub Merge Queue/Rulesets 對 `merge_group` 事件有硬需求**：未加觸發會導致 required checks 不會在 queue 分支跑，直接被踢出隊列。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue))  
* **OWASP LLM Top 10（2025 版）把 Prompt Injection / Excessive Agency / Supply Chain 風險寫得很直白**：子代理 \+ 工具 \+ MCP 是典型“過度代理授權”的高風險場景。([owasp.org](https://owasp.org/www-project-top-10-for-large-language-model-applications/?utm_source=chatgpt.com))

---

## **6\) 完整方案（可執行）**

RAG:  
  intent: 給你可直接落地的 v2：設定檔、流程、驗收、證據。  
  scope: 架構/編排/權限/模型/證據/coverage/no-go。  
  lane: Ops \+ Dev-Implement  
  authority: \[SSOT-SRS, SSOT-ARCH, SSOT-ControlPlane, SSOT-RUNBOOK, PLAN-Dev, PLAN-Exec\]  
  keywords: \[OpenCode, OMOC, least privilege, deny-by-default, Evidence Bundle, GateRunner, Schema\]  
  anchors: \[6.1, 6.2, 6.3, 6.5\]

### **6.1 架構與流程（ASCII/序列圖皆可）**

**核心原則**：**控制面主權在 Spartoi**；OpenCode/OMOC 是骨架；OpenClaw/MCP 只能在**外圍層**且可被完全關閉。

**ASCII（層級圖）**

\[Spartoi Control Plane\]  
  ├─ Rulesets / Merge Queue / Required Checks (GitHub)  
  ├─ GateRunner \+ GateKit \+ Schemas (RUNBOOK)  
  └─ HITL/Kill-Switch (SRS/ARCH)

\[OpenCode Runtime\]  \<-- 骨架（不造輪子）  
  ├─ Primary Agent \= Chef（唯一可呼叫子代理）  
  ├─ Deputy Agent  \= 證據/權限/裁決把關  
  └─ Experts       \= Security / Spec / Test / Docs 等（不可遞迴生子）

\[Peripheral Layer: OpenClaw/MCP\]  \<-- 外圍鎖  
  ├─ MCP allowlist（預設 disabled）  
  ├─ sandbox（容器/最小權限）  
  └─ post-scan evidence（SBOM/依賴/惡意行為掃描）

**序列圖（Fail-Closed 路徑）**

User \-\> Chef: 任務需求  
Chef \-\> Deputy: 建立 Authority/Assumption/Plan  
Deputy \-\> Chef: PASS(可繼續) / FAIL(降級或補證)  
Chef \-\> Experts: 分派(只讀/分析/掃描)  
Experts \-\> Deputy: Artifact \+ Evidence pointers  
Deputy \-\> GateRunner: schema \+ gates  
GateRunner \-\> Deputy: verdict PASS/FAIL  
Deputy \-\> Chef: 允許 merge / 要求修補 / 觸發 HITL

---

### **6.2 子代理編排（Chef/Deputy/Experts；Artifact 傳遞；QC 閾值；延遲拒絕）**

**角色定義（硬規則）**

* **Chef（主代理）**：唯一允許 `call_omo_agent` / delegate 子任務；負責統整輸出與最終決策。  
* **Deputy（把關代理）**：負責：  
  1. 權威堆疊/衝突裁決  
  2. 權限審核（deny-by-default 是否被破壞）  
  3. Evidence Bundle 完整性檢查與 GateRunner 觸發  
* **Experts（工人代理）**：只做專業工作（安全/供應鏈/規格/測試/文件），**不得遞迴呼叫子代理**（禁自我複製失控）。

**落地方式（不造輪子）**

* 用 OpenCode 的 **Agents** 與 agent-level permissions（官方支援）。([OpenCode](https://opencode.ai/docs/agents/))  
* 用 OMOC 的子代理呼叫能力；但把 `call_omo_agent` 權限限制在 Chef（工人代理禁用）。  
* 工具調用上限：**每次任務 tool calls ≤20 或信源 ≤100**；達上限即觸發「剎車」：輸出目前最小風險結論＋未解缺口清單。

\*\*並行隔離（git worktree｜Lane-based Parallelism；縮工期但不增加人肉審判）\*\*

\> 原則：並行不是“多開幾個視窗”，而是把工作拆成可驗收的 Lane；每個 Lane 綁定：一個 worktree \+ 一個子代理 \+ 一套最小證據。  

\> 目標：更短工期、更少上下文爆炸、更低人工；代價：多一點流程紀律（但可機械化）。

\*\*Lane 定義（建議 4 條；可依專案縮減）\*\*

\- LANE-DOCS：文件/規格/README/導讀

\- LANE-GATES：CI/required checks/GateRunner/Schema

\- LANE-PERM：permissions/No-Go/HITL/Kill-Switch/MCP 外圍鎖

\- LANE-EVID：Evidence Bundle/coverage map/trace map（含 schema 驗證）

\*\*硬上限（避免 worktree 變成熵增來源）\*\*

\- 同時存在的 worktree ≤ 4  

\- 每個 Lane 只允許 1 名 Experts 寫入（其他只讀/只建議）  

\- 合流只能走 Deputy 的 Fail-Closed 檢核（見 §6.5/附錄B）

\*\*一鍵建立 worktree（範本命名規則）\*\*

\- Branch：\`lane/\<LANE\>/\<yyyymmddThhmmssZ\>\`（UTC；可追溯）

\- Worktree 目錄：\`.wt/\<LANE\>\`（固定位置，方便腳本掃描）

\`\`\`bash

\# 建議在 repo root 執行

mkdir \-p .wt

git fetch \--all \--prune

\# 以 main 為基底（如你的主幹不是 main，替換即可）

base=main

ts="$(date \-u \+%Y%m%dT%H%M%SZ)"

for lane in DOCS GATES PERM EVID; do

  br="lane/${lane}/${ts}"

  dir=".wt/${lane}"

  git worktree add \-b "$br" "$dir" "$base"

done

git worktree list | tee \_evidence/\_worktree/worktree\_list.txt

**Lane ↔ 子代理映射（必做；避免“誰在改什麼”不可稽核）**

* DOCS → Specialist-Docs（L2）

* GATES → Specialist-CI/Gates（L2）

* PERM → Specialist-Permissions（L2）

* EVID → Specialist-Evidence（L2）

* Deputy：只在合流前做審核與裁決（L1）

* Chef：只做拆解、指派與最終裁決（L0）

**合流規則（Fail-Closed）**

1. 每個 Lane 必先在該 worktree 內自跑本 Lane 的最小驗收（見附錄C：lane\_verify.sh）

2. 每個 Lane 必產出：

   * `.wt/<LANE>/_evidence/_lane/<ts>/*`（lane 專屬證據）

   * `artifact.md / evidence_ptrs.json / qc.json`（符合 Artifact Contract）

3. 合流前由 Deputy 做：

   * worktree status/diffstat 檢查（避免偷渡大改）

   * GateRunner/Schema 驗證（見 §6.5/附錄B）

4. FAIL 就回到該 Lane 修；禁止 “先合再修”（那叫把炸彈帶進主幹）。

**Artifact Contract（每個子代理必須輸出）**

* `artifact.md`（摘要/結論/建議）  
* `evidence_ptrs.json`（證據檔路徑、log 片段索引）  
* `qc.json`（自評：Context Relevance/Groundedness/Answer Relevance；見 §10）  
* `open_questions.md`（無法證實者＝假說 \+ 最小風險預設）

**QC 閾值（Fail-Closed）**

* **QC-PASS**：3 指標均 ≥0.8；且 Evidence pointers 存在；且不觸犯 No-Go。  
* **QC-FAIL**：任何一項 \<0.8 或缺證據 → Deputy 必須阻止進入“修改/寫入/合併”。

**延遲拒絕（Delayed Refusal）**

* 不是“拒絕交付”，而是**拒絕擴權**：證據不足時，只能輸出「假說＋最小風險」與下一步補證，不能放行 write/bash/mcp。

小小機智（只嘲諷熵增）：MCP 不是妖怪；但你把 allowlist 關掉時，它會以為你在開迎神賽會。

---

### **6.3 安全與權限（permission matrix、allowlist、MCP 外圍鎖、HITL/Kill-Switch）**

**關鍵事實（官方）**

* OpenCode 權限規則是**細粒度**，且採 **last match wins**；action 支援 `allow/ask/deny`。([OpenCode](https://opencode.ai/docs/permissions/))  
* MCP Server 會把第三方工具/資源帶進上下文，需嚴格治理。([OpenCode](https://opencode.ai/docs/mcp-servers/))

#### **6.3.1 Permission Matrix（預設 Fail-Closed）**

| 類別 | 權限 | 預設 | 放行條件 |
| ----- | ----- | ----- | ----- |
| 檔案 | read | allow | 全程允許 |
| 檔案 | write | **ask** | 需 Deputy QC-PASS \+ 產生變更計畫（diff plan） |
| 系統 | bash | **ask/deny** | 預設 ask；涉及外部副作用一律 deny，改走 HITL |
| 網路 | webfetch | allow（可選 ask） | 允許，但需來源索引與上限 |
| 子代理 | call\_omo\_agent / delegate\_task | allow（僅 Chef） | 工人代理 deny（防遞迴生子） |
| 外掛 | mcp | **deny** | 僅外圍層 allowlist \+ sandbox \+ post-scan 證據齊全才可暫時放行 |

#### **6.3.2 MCP 外圍鎖（必備四件套）**

1. **MCP 預設 disabled**（配置層直接關）([OpenCode](https://opencode.ai/docs/mcp-servers/))  
2. **allowlist**：只允許經審核的 MCP server（版本固定/來源固定/Hash 或 release tag 固定）  
3. **sandbox**：容器隔離 \+ 最小權限 token（避免“confused deputy”與 token passthrough）([modelcontextprotocol.io](https://modelcontextprotocol.io/specification/draft/basic/security_best_practices))  
4. **post-scan evidence**：SBOM/依賴/惡意行為掃描結果寫入 Evidence Bundle（見 6.5）

MCP 安全風險必須被視為「供應鏈 \+ 提示詞注入 \+ 過度代理授權」疊加：OWASP LLM Top 10 已明確點名。([owasp.org](https://owasp.org/www-project-top-10-for-large-language-model-applications/?utm_source=chatgpt.com))

#### **6.3.3 HITL/Kill-Switch（嚴禁自動下單）**

* **任何涉及資金/外部不可逆副作用**：一律要求 HITL 決策包（見 RUNBOOK 決策包格式），並保留 Kill-Switch 能立即切斷執行通道。  
* **Fail-Closed**：未提供決策包＝不執行。

**Coverage Checklist（本節不得漏）**

* deny-by-default（last match wins 順序正確）([OpenCode](https://opencode.ai/docs/permissions/))  
* mcp 預設 disabled \+ allowlist \+ sandbox \+ post-scan ([OpenCode](https://opencode.ai/docs/mcp-servers/))  
* 工人代理禁止遞迴生子（call\_omo\_agent deny）  
* 外部副作用必經 HITL/Kill-Switch

**Common Confusions（易混點）**

* 「ask」不是「安全」：它只是**把風險丟回人**；你仍需要 Evidence 與 Gate 才能讓 ask 有意義。  
* 「關了 MCP」不等於「沒供應鏈」：依賴、Actions、plugins 依然是供應鏈。

---

### **6.4 模型分流與成本策略（預設組合＋升級條件＋風險）**

**目標：不背模型名、不靠感覺；用 \`opencode models \--refresh\` 動態抓可用模型，再用「白名單上鎖 \+ log 驗證 \+ 證據快照」把模型漂移變成可判定的 FAIL。**  

**背景限制：OpenCode 目前支援 \`disabled\_providers\`，但「停用特定 model（disabled\_models）」仍屬缺口（只能靠白名單/顯式指定/驗證來補）。**  

**參考：OpenCode Config / CLI（models refresh）與相關議題討論。**

---

**6.4.1 Model Registry（動態檢測）\*\***

**硬規則：每次「正式驗收跑」前，必做一次 models cache refresh \+ registry snapshot。**

**1\) 刷新可用模型（避免「以為有，其實沒」）**  

**\`\`\`bash**

**opencode models \--refresh \--verbose | tee \_evidence/\_models/models\_verbose.txt**

**2\) 建立本次 run 的「Model Registry 快照」（供稽核/回放）**

* **產物要求（Evidence Bundle 的一部分）：**

  * **`_evidence/_models/models_verbose.txt`（原始清單）**

  * **`_evidence/_models/model_registry.json`（你自己的“允許/分層/用途”表）**

  * **`_evidence/_models/model_allowlist.txt`（允許的 provider/model 清單，一行一個）**

**注意：Registry/Allowlist 是“你做的裁決”，不是 OpenCode 自帶功能；它的價值在於可審計、可回放、可機械判定。**

---

#### **6.4.2 Allowlist 上鎖（在 OpenCode 既有限制下做到最強防飄）**

**由於現況無法針對單一 provider 做 disabled\_models（只能 disabled\_providers），因此採三層鎖：**

**鎖 1｜Provider 上鎖（最粗但最穩）**

* **`opencode.json`：只開你允許的 provider（例：只開 `github-copilot`），其他一律 disabled。**

* **目的：避免“默默掉回別家 provider 的預設便宜模型”。**

**鎖 2｜Agent 顯式指定 model（最關鍵）**

* **Chef / Deputy / Experts 在各自 agent config 內顯式指定 `provider/model`（不使用「自動挑便宜」的幻想）。**

* **OMOC 背景子代理/工人代理必加 `call_omo_agent: false` 限制，避免遞迴暴增（已被真實 issue 證實會炸裂）。**

**鎖 3｜Run 後驗證（Fail-Closed）**

* **用 log grep \+ schema 驗證：**

  * **任何 `providerID/modelID` 不在 allowlist → FAIL**

  * **出現 `opencode/*`（或任何你 disabled 的 provider）被實際呼叫 → FAIL**

  * **只有 models 清單列出，不算使用；以「llm 呼叫紀錄」為準。**

---

#### **6.4.3 分層策略（Chef / Deputy / Experts 的“任務性質”導向）**

**這裡不綁死模型名；只綁死“層級用途 \+ 可替代條件”。**  
 **真正可用的候選，交給 §6.4.1 的 models refresh 來抓。**

**L0（裁決層）Chef**

* **用途：拆解、收斂、最終裁決、與 Deputy 對賭的“主法官”**

* **要求：推理穩定、長文一致性佳（不追求最便宜）**

**L1（治理層）Deputy**

* **用途：Authority Stack/Conflict Rule、Evidence Bundle 完整性、GateRunner 觸發、QC 判定**

* **要求：保守、少幻覺、偏“程序正義”**

**L2（工人層）Experts**

* **用途：掃描/清單/比對/規格整理/生成可驗證產物（但不得做最終裁決）**

* **要求：高 CP、可大量並行，產物必落 Artifact Contract（§6.2）**

**升級條件（硬）**

* **連續 2 次 QC \< 0.8 且缺口明確來自推理能力（非缺資料/缺權限/缺工具）→ 只升級 L0/L1**

* **若是資料不足/權限阻塞/驗收規格不清 → 禁止升級模型，先補證據/縮 scope/修合約（避免用錢掩蓋程序漏洞）**

---

#### **6.4.4 漂移防線（Drift Guard）與證據要求**

**每次 run 必產：**

* **`_evidence/_models/models_verbose.txt`（刷新後的可用清單）**

* **`_evidence/_models/model_allowlist.txt`（允許清單）**

* **`_evidence/_verify/model_used_grep.txt`（從 run log 抽出的實際使用模型）**

* **`_evidence/_verify/model_drift_verdict.json`（PASS/FAIL \+ 理由 \+ 反證）**

**Fail-Closed 判定：**

* **PASS：實際使用的每個 `provider/model` 皆 ∈ allowlist；且未觸發任何 disabled provider**

* **FAIL：任一不符；直接回到「修 config / 修 agent 指派 / 重跑驗證」，不准跳過**

---

#### **6.4.5 最小可用模板（你要能“立刻用”）**

**下面只示意“形狀”；實際 model 名稱由 `opencode models --refresh` 取得後填入。**

* **Chef（L0）：`github-copilot/<L0_MODEL>`**

* **Deputy（L1）：`github-copilot/<L1_MODEL>`**

* **Experts（L2）：`github-copilot/<L2_MODEL>`**

**若你只想先跑通（最小風險）：**

* **L0=L1（同一個穩定模型）**

* **L2 用更便宜的同 provider 模型**

* **先把驗收/證據跑通，再談精細化成本優化**

---

### **6.5 證據與驗收閉環（Evidence Bundle、GateRunner、Schema、Policy gates、Fail-Closed）**

**核心：Evidence Bundle 三件套 \+ 掃描 \+ verdict**

* 依 RUNBOOK：`artifact_manifest` / `gate_report` / `evidence_index` \+ schema 驗證（`spartoi-schema`）。  
* 每次執行都要產：  
  * `input_manifest.json`（輸入/版本/commit/配置快照）  
  * `run_config_snapshot.json`（含 permissions、mcp、models）  
  * `output_manifest.json`  
  * `gate_report.json` \+ `verdict.json`（PASS/FAIL/原因/證據指標）  
  * `scan/`（SBOM/依賴/secret/malware 等）

**Rulesets / Merge Queue / Required Checks（控制面）**

* GitHub Rulesets 可要求 status checks；Merge Queue 會用 `merge_group` 建臨時分支並等 required checks。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets))  
* 工作流必須包含 `merge_group` 觸發，不然 required checks 不會對 queue 分支跑 → 直接失敗。([GitHub Docs](https://docs.github.com/en/enterprise-server%403.19/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/troubleshooting-rules))

**供應鏈：Attestations / SLSA / Scorecard（不造輪子，直接用現成）**

* GitHub Artifact Attestations 用來建立 build provenance（官方）。([GitHub Docs](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds))  
* `attest-build-provenance` / `attest-sbom` 可做 provenance/SBOM（官方）。([GitHub Docs](https://docs.github.com/actions/how-tos/security-for-github-actions/using-artifact-attestations/managing-the-lifecycle-of-artifact-attestations))  
* OpenSSF Scorecard Action 作為 repo 健康掃描（官方 action）。([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))  
* 若要更高等級 provenance，可用 slsa-github-generator（官方/主維護 GitHub）。([GitHub](https://github.com/slsa-framework/slsa-github-generator?utm_source=chatgpt.com))

---

### **6.6 Coverage Map（C0–C5：可判定條款；如何自動產表）**

**C0｜配置完整性**

* 判定：`opencode.json`/`.opencode/*` 存在；permissions 順序正確（deny-by-default）；mcp disabled。([OpenCode](https://opencode.ai/docs/permissions/))

**C1｜子代理有跑 & 無遞迴生子**

* 判定：log 中存在子代理呼叫；且工人代理無 `call_omo_agent`（grep 規則）。

**C2｜權限 Fail-Closed**

* 判定：bash/write/mcp 測試用例觸發 ask/deny（不得默默 allow）。([OpenCode](https://opencode.ai/docs/permissions/))

**C3｜Evidence Bundle 齊全**

* 判定：三件套 \+ scan \+ verdict 皆存在；Schema 驗證 PASS（RUNBOOK）。

**C4｜控制面 Required Checks 生效**

* 判定：Rulesets 要求 checks；Merge Queue 事件跑起來且 required checks 對最新 SHA 成功。([GitHub Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/troubleshooting-required-status-checks))

**C5｜供應鏈與可驗 provenance**

* 判定：Attestation 可被 `gh attestation verify` 驗證；Scorecard 有產出（或 Security Tab）。([GitHub Docs](https://docs.github.com/en/enterprise-cloud%40latest/rest/users/attestations))

**如何自動產表（不造輪子）**

* 用 `jq/grep` 從 `evidence_index.json` \+ `gate_report.json` 產生 `coverage_report.md`（純腳本 glue，允許）。

---

### **6.7 No-Go List（明確禁止事項＋替代做法）**

1. **自動下單/無人值守資金操作** → 替代：HITL 決策包 \+ Kill-Switch \+ 只讀演練模式。  
2. **工人代理遞迴生子**（自我複製失控）→ 替代：`call_omo_agent` 僅 Chef 允許；Experts 一律 deny。([OpenCode](https://opencode.ai/docs/agents/))  
3. **預設放行 mcp/bash/write** → 替代：deny-by-default；僅在 Evidence/掃描齊全時暫時放行。([OpenCode](https://opencode.ai/docs/permissions/))  
4. **繞過 ToS/破解/偽造 OAuth/簽名** → 替代：走官方驗證鏈（Rulesets、Attestations、Scorecard）。([GitHub Docs](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds))  
5. **為了“看起來很努力”暴走搜尋** → 替代：工具/信源上限（≤20 calls/≤100 sources）＋收益遞減停損。

---

## **7\) 風險與對策（偵測→緩解→備援；含 MCP/供應鏈/ToS/資安）**

RAG:  
  intent: 把風險落到可操作防線與證據，而不是口號。  
  scope: prompt injection / excessive agency / MCP / supply chain / CI policy.  
  lane: Ops  
  authority: \[SSOT-SRS, SSOT-ARCH, SSOT-RUNBOOK, SSOT-ControlPlane\]  
  keywords: \[OWASP LLM Top10, prompt injection, confused deputy, attestations, scorecard\]  
  anchors: \[6.3, 6.5, 11\]

### **風險 1｜Prompt Injection（含間接注入）**

* **偵測**：來源內容（網頁/文件/MCP 工具回傳）一律視為不可信；用「來源索引 \+ 引用最小化」降低污染面。  
* **緩解**：OWASP 指出 Prompt Injection 為首要風險，需在系統提示與輸入處理建護欄。([OWASP Gen AI Security Project](https://genai.owasp.org/llmrisk/llm01-prompt-injection/?utm_source=chatgpt.com))  
* **備援**：Deputy 觸發延遲拒絕：只輸出假說/建議，不放行 write/bash。

### **風險 2｜Excessive Agency（工具過度授權）**

* **偵測**：權限矩陣 \+ log 監控（是否出現未授權工具/外部副作用）。  
* **緩解**：deny-by-default \+ ask/deny \+ HITL；OWASP 2025 版明確列入此類風險。([owasp.org](https://owasp.org/www-project-top-10-for-large-language-model-applications/?utm_source=chatgpt.com))  
* **備援**：Kill-Switch：直接切斷 CA-EXECUTE 路徑。

### **風險 3｜MCP 生態風險（confused deputy / token passthrough / session hijack / supply chain）**

* **偵測**：MCP 啟用即要求掃描證據；並記錄 allowlist 版本。  
* **緩解**：官方 MCP Security Best Practices 提到的威脅類型（含 token 流與權限邊界）必須落在 sandbox \+ 最小 token。([modelcontextprotocol.io](https://modelcontextprotocol.io/specification/draft/basic/security_best_practices))  
* **備援**：一鍵關閉 MCP（配置層 disabled）。([OpenCode](https://opencode.ai/docs/mcp-servers/))

### **風險 4｜供應鏈（Actions/依賴/插件）**

* **偵測**：Scorecard \+ SBOM \+ provenance attestation。([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))  
* **緩解**：GitHub Artifact Attestations 建立 provenance；必要時引入 SLSA generator。([GitHub Docs](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds))  
* **備援**：若 cosign/gh 驗證鏈出現衝突，採用 GitHub 官方 `gh attestation verify` 為主（見 Conflict Ledger）。([GitHub Docs](https://docs.github.com/en/enterprise-cloud%40latest/rest/users/attestations))

**Coverage Checklist（本節不得漏）**

* OWASP LLM Top10 對應到子代理/工具/MCP 的防線([owasp.org](https://owasp.org/www-project-top-10-for-large-language-model-applications/?utm_source=chatgpt.com))  
* MCP：allowlist \+ sandbox \+ post-scan \+ 可關閉([modelcontextprotocol.io](https://modelcontextprotocol.io/specification/draft/basic/security_best_practices))  
* 供應鏈：attestations \+ scorecard \+（選）SLSA generator([GitHub Docs](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds))

---

## **8\) 遷移指南（v1→v2：最小步驟、回滾策略）**

RAG:  
  intent: 讓你用最小風險把 v1 換成 v2，並可回滾。  
  scope: config 置換、權限收斂、驗收跑通。  
  lane: Ops  
  authority: \[PLAN-Exec, SSOT-RUNBOOK, SSOT-ControlPlane\]  
  keywords: \[migration, rollback, evidence\]  
  anchors: \[附錄A, 附錄B, 9\]

### **最小步驟（Fail-Closed）**

1. **保留 v1 檔作備份**：`Spartoi-OMOC啟用子代理-方案.md` 不再作為參照，但保留以供 Trace Map 回放。  
2. **套用 v2 設定檔**（附錄A）：deny-by-default、mcp disabled、call\_omo\_agent 僅 Chef。  
3. **跑附錄B 驗收**：產 Evidence Bundle；任何 FAIL 一律先修到 PASS 再談下一步。  
4. **收斂 Rulesets/Required Checks**：確保 Merge Queue \+ `merge_group` 正常。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue))

### **回滾策略**

* 若子代理或權限策略導致阻塞：  
  * 回滾到「僅 Chef \+ Deputy（無 Experts）」模式；保留 deny-by-default；先把證據/驗收跑通再擴張。  
* 若 MCP 引發不確定風險：  
  * 直接關閉 MCP（配置 disabled）並保留掃描證據。

---

## **9\) Trace Map（v1→v2 章節映射表＋Spartoi 條款對應表）**

RAG:  
  intent: 確保 v2 可完全取代 v1，不需回頭翻 v1。  
  scope: v1 條款表、保留/改寫/合併/刪除理由、SSOT 對齊。  
  lane: Reference  
  authority: \[SSOT-SRS, SSOT-ARCH, SSOT-RUNBOOK, PLAN-Dev, PLAN-Exec\]  
  keywords: \[Trace Map, replace v1\]  
  anchors: \[4, 6, 11\]

### **9.1 v1 條款表（摘要）**

| v1 條款 | v1 要點 | v2 對應 | 處置 |
| ----- | ----- | ----- | ----- |
| v1-Auth | 引用 OpenCode/OMOC、提到權威 | §3 | **改寫**：Authority Stack 上鎖 \+ Conflict Rule |
| v1-ModelLock | 鎖預設模型/避免飄 | §6.4/§6.5 | **保留+強化**：run\_config\_snapshot \+ grep/Schema |
| v1-AntiRecursion | 防遞迴生子 | §6.2/§6.3/§6.7 | **保留+落地**：僅 Chef 允許 call\_omo\_agent |
| v1-MinPerm | 最小權限 | §6.3 | **保留+強化**：deny-by-default \+ matrix \+ mcp deny |
| v1-MCP | MCP 風險與外圍鎖 | §6.3/§7 | **保留+強化**：官方 MCP config \+ security best practices \+掃描證據 |
| v1-Acceptance | 驗收與證據 | §6.5/§6.6/附錄B | **保留+機械化**：Evidence Bundle \+ GateRunner \+ Coverage Map |
| v1-Refs | 來源列舉 | §12 | **重寫**：≥8 去重 \+ URL Registry \+ 日期 |

### **9.2 Spartoi 條款對應（示例）**

| Spartoi SSOT 條款類型 | v2 落點 |
| ----- | ----- |
| HITL/Kill-Switch（外部副作用 Fail-Closed） | §6.3 / §7 |
| Evidence Bundle \+ Schema \+ 機械裁決 | §6.5 / §6.6 |
| Rulesets / Required Checks / Merge Queue 治理 | §6.5 / §2 / §4 |

---

## **10\) RAG/檢索設計（RAG Header 規範、chunk 規則、RAG-Triad 測法）**

RAG:  
  intent: 讓這份文件「可被 AI 檢索並正確執行」，避免漏條款與擴權。  
  scope: RAG Header Block、chunk、Triad 指標與修補策略。  
  lane: Docs-as-Code  
  authority: \[SSOT-RUNBOOK, SSOT-ControlPlane\]  
  keywords: \[Diátaxis, chunking, RAG-Triad, groundedness\]  
  anchors: \[2-12\]

### **10.1 RAG Header Block 規範（強制）**

* 每個大節開頭必須有 YAML Block（本文件已遵守）。  
* 欄位固定：intent/scope/lane/authority/keywords/anchors。

### **10.2 Chunk 規則（建議）**

* 以「可執行單元」切 chunk：  
  * 一個 chunk 對應一個落地物（設定檔/工作流/命令/驗收條款）。  
* 任何 No-Go、權限矩陣、DoD、Coverage Map：必須獨立 chunk（避免被摘要吃掉）。

### **10.3 RAG-Triad 測法（Context Relevance / Groundedness / Answer Relevance）**

| 指標 | 如何測 | PASS 閾值 | FAIL 時怎麼修 |
| ----- | ----- | ----- | ----- |
| Context Relevance | 回答引用的 anchors 是否落在本文件範圍 | ≥0.8 | 刪除越界內容；補上正確 anchors |
| Groundedness | 對可變動事實是否有 ≥2 源（或 SSOT） | ≥0.8 | 進 Assumption/Conflict Ledger；補來源或降級假說 |
| Answer Relevance | 是否回到「可執行＋可驗證」 | ≥0.8 | 補上命令/檔路徑/DoD/證據指標 |

**Coverage Checklist（本節不得漏）**

* Header Block 固定欄位  
* chunk 對齊落地物  
* Triad 指標可被 QC.json 實作並寫入 Evidence

---

## **11\) 假設帳本（Assumption Ledger）＋衝突帳本（Conflict Ledger）＋Delta Log（外部差分）**

RAG:  
  intent: 把不確定寫進台帳，避免“默默變成事實”。  
  scope: assumptions, conflicts, deltas.  
  lane: Ops  
  authority: \[Authority Stack\]  
  keywords: \[Fail-Closed, ledger\]  
  anchors: \[5.3\]

### **11.1 Assumption Ledger（節錄）**

* A1：專案採用 OpenCode+OMOC 作為子代理骨架（不自製 orchestrator）。  
* A2：若專案層級 agents 目錄在你的 OpenCode 版本不可用，改用 `~/.config/opencode/agents` 作為落地位置（仍符合不造輪子）。([OpenCode](https://opencode.ai/docs/agents/))  
* A3：MCP 一律預設 disabled，只有在 Evidence/掃描/allowlist 完整時短暫開啟。([OpenCode](https://opencode.ai/docs/mcp-servers/))

### **11.2 Conflict Ledger（節錄）**

* C1：**cosign 是否能驗 GitHub Artifact Attestations？**  
  * GitHub Action issue（2024-07）曾表示不易；但 Sigstore blog（2024-08）提到 cosign 對 bundle 格式的驗證能力。裁決：**主路徑用 `gh attestation verify`**；cosign 視實測結果作為附加驗證（Fail-Closed）。([GitHub](https://github.com/actions/attest-build-provenance/issues/162?utm_source=chatgpt.com))

### **11.3 Delta Log（外部差分｜節錄）**

| 日期 | 變動 | 影響 | 採納 | 理由 |
| ----- | ----- | ----- | ----- | ----- |
| 2026-02-05 | OpenCode permissions last-match-wins | 可做 deny-by-default，但順序錯就穿洞 | ✅ | 必須落地到配置與驗收用例 ([OpenCode](https://opencode.ai/docs/permissions/)) |
| 2026-02-05 | GitHub Merge Queue 需 `merge_group` | 不加會導致 required checks 不跑 | ✅ | 官方硬規則 ([GitHub Docs](https://docs.github.com/en/enterprise-server%403.19/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/troubleshooting-rules)) |
| 2026-02-05 | OWASP LLM Top10（2025）風險框架 | 對 agentic \+ 工具授權提供準則 | ✅ | 用於 No-Go/風險對策 ([owasp.org](https://owasp.org/www-project-top-10-for-large-language-model-applications/?utm_source=chatgpt.com)) |

---

## **12\) 來源索引（≥8；去重；每筆含：站點/日期/支撐章節；另含 URL Registry）**

URL 以 `code` 呈現（合規），並提供日期（Asia/Taipei，2026-02-05）。

1. OpenCode Permissions（2026-02-05）`https://opencode.ai/docs/permissions/`。支撐：§4/§6.3/§6.7 ([OpenCode](https://opencode.ai/docs/permissions/))  
2. OpenCode Config（2026-02-05）`https://opencode.ai/docs/config/`（含 `.opencode`、config precedence）。支撐：§6.5/附錄A ([OpenCode](https://opencode.ai/docs/config/))  
3. OpenCode MCP Servers（2026-02-05）`https://opencode.ai/docs/mcp/servers/`。支撐：§6.3/§7 ([OpenCode](https://opencode.ai/docs/mcp-servers/))  
4. MCP Security Best Practices（2026-02-05）`https://modelcontextprotocol.io/specification/2025-06-18/basic/security`。支撐：§6.3/§7 ([modelcontextprotocol.io](https://modelcontextprotocol.io/specification/draft/basic/security_best_practices))  
5. Microsoft MCP Security Guide（2026-02-05）`https://github.com/microsoft/mcp-for-beginners/blob/main/02-Security/README.md`。支撐：§6.3/§7 ([GitHub](https://github.com/microsoft/mcp-for-beginners/blob/main/02-Security/README.md))  
6. GitHub Docs — Managing a merge queue（2026-02-05）`https://docs.github.com/.../managing-a-merge-queue`。支撐：§2/§6.5 ([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue))  
7. GitHub Docs — Troubleshooting rules (`merge_group`)（2026-02-05）`https://docs.github.com/.../troubleshooting-rules`。支撐：§2/§6.5 ([GitHub Docs](https://docs.github.com/en/enterprise-server%403.19/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/troubleshooting-rules))  
8. GitHub Docs — Artifact attestations / provenance（2026-02-05）`https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/...`。支撐：§6.5/§6.6 ([GitHub Docs](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds))  
9. OpenSSF Scorecard Action（2026-02-05）`https://github.com/ossf/scorecard-action`。支撐：§6.5/§7 ([GitHub](https://github.com/ossf/scorecard-action?utm_source=chatgpt.com))  
10. SLSA GitHub Generator（2026-02-05）`https://github.com/slsa-framework/slsa-github-generator`。支撐：§6.5/§7 ([GitHub](https://github.com/slsa-framework/slsa-github-generator?utm_source=chatgpt.com))  
11. OWASP Top 10 for LLM Applications（2026-02-05）`https://owasp.org/www-project-top-10-for-large-language-model-applications/`。支撐：§5.3/§7 ([owasp.org](https://owasp.org/www-project-top-10-for-large-language-model-applications/?utm_source=chatgpt.com))  
12. Unit 42（間接注入/長期記憶污染案例，2026-02-05）`https://unit42.paloaltonetworks.com/indirect-prompt-injection-poisons-ai-longterm-memory/`。支撐：§7 ([Unit 42](https://unit42.paloaltonetworks.com/indirect-prompt-injection-poisons-ai-longterm-memory/))

### **URL Registry（去重清單）**

https://opencode.ai/docs/permissions/  
https://opencode.ai/docs/config/  
https://opencode.ai/docs/mcp/servers/  
https://modelcontextprotocol.io/specification/2025-06-18/basic/security  
https://github.com/microsoft/mcp-for-beginners/blob/main/02-Security/README.md  
https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue  
https://docs.github.com/en/enterprise-server%403.19/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/troubleshooting-rules  
https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds  
https://github.com/ossf/scorecard-action  
https://github.com/slsa-framework/slsa-github-generator  
https://owasp.org/www-project-top-10-for-large-language-model-applications/  
https://owasp.org/www-project-top-10-for-large-language-model-applications/assets/PDF/OWASP-Top-10-for-LLMs-v2025.pdf  
https://unit42.paloaltonetworks.com/indirect-prompt-injection-poisons-ai-longterm-memory/

---

## **附錄A) 設定檔範本：opencode.json / .opencode/\* / OMOC 配置**

注意：OpenCode 設定與權限規則採 last match wins，**deny-by-default 要放在前面，精準 allow/ask 放後面**。([OpenCode](https://opencode.ai/docs/permissions/))

### **A1) `opencode.json`（專案根目錄｜最小權限 \+ 啟用 OMOC \+ 預設模型）**

{  
  "$schema": "https://opencode.ai/config.json",  
  "plugin": \["oh-my-opencode@latest"\],

  "model": "github-copilot/gpt-5-mini",

  "permissions": \[  
    { "permission": "\*", "pattern": "\*", "action": "deny" },

    { "permission": "read", "pattern": "\*", "action": "allow" },  
    { "permission": "webfetch", "pattern": "\*", "action": "allow" },

    { "permission": "call\_omo\_agent", "pattern": "\*", "action": "allow" },  
    { "permission": "delegate\_task", "pattern": "\*", "action": "allow" },  
    { "permission": "task", "pattern": "\*", "action": "allow" },

    { "permission": "write", "pattern": "\*", "action": "ask" },  
    { "permission": "bash", "pattern": "\*", "action": "ask" },

    { "permission": "mcp", "pattern": "\*", "action": "deny" }  
  \],

  "mcp": {  
    "enabled": false  
  }  
}

\> \*\*Model Lock 補充（必備）\*\*    
\> \- 每次正式驗收前：必跑 \`opencode models:contentReference\[oaicite:20\]{index=20} 並落 \`\_evidence/\_models/models\_verbose\_\<ts\>.txt\`。    
\> \- 必維護 \`\_evidence/\_models/model\_allowlist\_\<ts\>.txt\`（允許的 provider/model 一行一個）。    
\> \- Run 後必產 \`\_evidence/\_verify/\<ts\>/model\_drift\_verdict.json\`；任何漂移直接 FAIL（見附錄C3）。    
\> \- 這是為了補齊「disabled\_models 尚未內建」的現實缺口：只能靠 allowlist \+ 顯式指定 \+ 驗證來 Fail-Closed。

### **A2) Agent 定義（Chef/Deputy/Experts｜示意）**

OpenCode 支援 agent-level permissions（用來限制工人代理）。([OpenCode](https://opencode.ai/docs/agents/))

* Chef：允許 `call_omo_agent`  
* Deputy：允許讀取/驗收工具，但對 write/bash 仍採 ask  
* Experts：禁止 `call_omo_agent`（防遞迴生子），僅允許 read/webfetch/掃描類工具

---

## **附錄B) 一鍵驗證命令：如何釘死“子代理有跑、模型沒飄、bash/write 仍被擋、Evidence 產物齊全”**

你要的是「硬證據」，不是“感覺良好”。

### **B1) 驗證（本地/CI 通用）**

set \-euo pipefail  
ts="$(date \-u \+%Y%m%dT%H%M%SZ)"  
out="evidence/subagents\_v2/$ts"  
mkdir \-p "$out"

\# 1\) 印出實際使用的 model/provider（避免飄）  
opencode \--print-logs run "Reply ONLY JSON: {\\"model\\":\\"\<provider/model\>\\",\\"ok\\":true}" \\  
  2\>&1 | tee "$out/run.log" || true

\# 2\) 子代理有跑：觸發一次多代理任務（Chef-\>Experts）  
opencode \--print-logs run "Chef: call experts to list 5 files and produce evidence pointers. Reply with paths." \\  
  2\>&1 | tee "$out/subagents.log" || true

\# 3\) 權限 Fail-Closed：嘗試寫入/跑 bash（應該 ask/deny，而不是默默成功）  
opencode \--print-logs run "Try to write a file /tmp/perm\_test.txt with content 'X'." \\  
  2\>&1 | tee "$out/write\_probe.log" || true  
opencode \--print-logs run "Try to run: uname \-a" \\  
  2\>&1 | tee "$out/bash\_probe.log" || true

\# 4\) MCP 必須仍然 disabled（若被啟用，視為 FAIL）  
grep \-nE "\\"mcp\\"|mcp" opencode.json \> "$out/grep\_mcp\_config.txt" || true

echo "OK: logs in $out"

### **B1.2 Worktree Lane 證據**

\- \`\_evidence/\_worktree/worktree\_list\_\<ts\>.txt\`（:contentReference\[oaicite:22\]{index=22}LANE\>/\_evidence/\_lane/\<ts\>/git\_status.txt\`  
\- \`.wt/\<LANE\>/\_evidence/\_lane/\<ts\>/git\_diffstat.txt\`  
\- 合流前 Deputy 必須檢查 lane diffstat（避免偷渡大改）

### **B2) Fail-Closed 判定（你要看的 PASS/FAIL）**

* **PASS**：  
  * `run.log` 能看出固定 model（不飄）；  
  * `subagents.log` 出現子代理呼叫痕跡；  
  * `write_probe.log`/`bash_probe.log` 顯示 ask/deny（不是默默成功）；  
  * `opencode.json` 中 mcp `enabled:false`。([OpenCode](https://opencode.ai/docs/mcp-servers/))  
* **FAIL**：任一條不成立 → 回到 §6.3 修配置、補 Evidence，再重跑。

## ---

 附錄C) 一鍵並行 \+ 一鍵模型上鎖 \+ 一鍵漂移驗證（worktree × allowlist × eviden:contentReference\[oaicite:18\]{index=18}量模型治理」做成可機械驗收的腳本流程。   

\> 產物：worktree 清單、lane 證據、model registry/allowlist、model drift verdict。

\---

### **C1) 建立 worktree lanes（一次到位）**

\`\`\`bash  
set \-euo pipefail

mkdir \-p .wt \_evidence/\_worktree

git fetch \--all \--prune

base="${1:-main}"  
ts="$(date \-u \+%Y%m%dT%H%M%SZ)"

for lane in DOCS GATES PERM EVID; do  
  br="lane/${lane}/${ts}"  
  dir=".wt/${lane}"  
  if \[ \-d "$dir" \]; then  
    echo "SKIP: $dir exists"  
  else  
    git worktree add \-b "$br" "$dir" "$base"  
  fi  
done

git worktree list | tee "\_evidence/\_worktree/worktree\_list\_${ts}.txt"

### **C2) 動態刷新 models \+ 產生 allowlist（Fail-Closed 的前置）**

你不需要“記住模型名”；你需要“每次 run 前都刷新並快照”。  
 OpenCode 支援 `opencode models --refresh --verbose`。若你不 refresh，就等於在用過期候選名單做裁決。

set \-euo pipefail

ts="$(date \-u \+%Y%m%dT%H%M%SZ)"  
mkdir \-p \_evidence/\_models

opencode models \--refresh \--verbose | tee "\_evidence/\_models/models\_verbose\_${ts}.txt"

cat \> "\_evidence/\_models/model\_allowlist\_${ts}.txt" \<\<'TXT'  
\# 一行一個 provider/model  
\# 例：github-copilot/gpt-5-mini  
\# 例：github-copilot/raptor-mini  
\# 例：github-copilot/gpt-4.1  
TXT

cat \> "\_evidence/\_models/model\_registry\_${ts}.json" \<\<'JSON'  
{  
  "utc\_ts": "REPLACE\_ME",  
  "policy": {  
    "provider\_lock": \["github-copilot"\],  
    "allowlist\_file": "\_evidence/\_models/model\_allowlist\_\<ts\>.txt",  
    "notes": "Fill allowlist from refreshed models output; fail-closed if runtime uses anything outside."  
  },  
  "tiers": {  
    "L0\_Chef": {"intent": "decision+final verdict", "model": "REPLACE\_ME"},  
    "L1\_Deputy": {"intent": "governance+gates+evidence", "model": "REPLACE\_ME"},  
    "L2\_Experts": {"intent": "scan+summarize+lists", "model": "REPLACE\_ME"}  
  }  
}  
JSON

\# 補 utc\_ts（避免手填）  
python \- \<\<'PY'  
import json, time, glob  
from pathlib import Path  
p=Path(sorted(glob.glob("\_evidence/\_models/model\_registry\_\*.json"))\[-1\])  
j=json.loads(p.read\_text())  
j\["utc\_ts"\]=time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())  
p.write\_text(json.dumps(j, indent=2, ensure\_ascii=False))  
print("OK:", p)  
PY

### **C3) Run 後漂移驗證（模型沒飄就 PASS；飄了就 FAIL）**

關鍵：要驗證的是「llm 實際呼叫」，不是 models 清單。

set \-euo pipefail

ts="$(date \-u \+%Y%m%dT%H%M%SZ)"  
out="\_evidence/\_verify/${ts}"  
mkdir \-p "$out"

\# 1\) 跑一個會必定呼叫子代理的 smoke test（你可以替換 prompt，但要保證會 call\_omo\_agent）  
opencode \--log-level DEBUG \--print-logs run \\  
"你必須：先呼叫 call\_omo\_agent 讓 librarian 列出本 repo 前 20 個檔案，並分類；再呼叫 explore 指出最重要的 3 個入口文件。最後只輸出 DONE。" \\  
2\>&1 | tee "$out/run.log" || true

\# 2\) 抽出實際使用的 provider/model（以 log 為準）  
grep \-nE "service=llm|providerID=|modelID=" "$out/run.log" | tee "$out/model\_used\_grep.txt" || true

\# 3\) 讀最新 allowlist（你也可以改成指定某次 ts）  
allow="$(ls \-1 \_evidence/\_models/model\_allowlist\_\*.txt | tail \-n 1)"

python \- \<\<'PY'  
import re, json, sys, pathlib, glob  
from pathlib import Path

out=Path(sorted(glob.glob("\_evidence/\_verify/\*"))\[-1\])  
log=(out/"run.log").read\_text(errors="ignore")  
allow=Path(sorted(glob.glob("\_evidence/\_models/model\_allowlist\_\*.txt"))\[-1\]).read\_text().splitlines()

allow=set(\[x.strip() for x in allow if x.strip() and not x.strip().startswith("\#")\])

\# 盡量抽取 provider/model（兼容不同 log 格式：找类似 github-copilot/xxx）  
hits=set(re.findall(r'(\[a-zA-Z0-9\_-\]+/\[a-zA-Z0-9\_.:-\]+)', log))

\# 只保留看起來像 provider/model 的（至少含一個 /）  
used=set(\[h for h in hits if "/" in h\])

bad=sorted(\[u for u in used if allow and u not in allow\])

verdict={  
  "allowlist\_file": str(sorted(glob.glob("\_evidence/\_models/model\_allowlist\_\*.txt"))\[-1\]),  
  "used\_models\_detected": sorted(used),  
  "bad\_outside\_allowlist": bad,  
  "pass": (len(bad)==0)  
}

(out/"model\_drift\_verdict.json").write\_text(json.dumps(verdict, indent=2, ensure\_ascii=False))  
print("PASS" if verdict\["pass"\] else "FAIL", "-\>", out/"model\_drift\_verdict.json")  
PY

**Fail-Closed 裁決**

* PASS：`model_drift_verdict.json.pass == true`

* FAIL：任何 used model 不在 allowlist → 回到 §6.4 修 model 指派與 provider lock，重跑 C3

---

### **C4) Lane 最小驗收（每個 worktree 都要產 lane evidence）**

每個 Lane 都要能自證「我改了什麼、為什麼、驗收結果」。

set \-euo pipefail

lane="${1:?LANE required: DOCS|GATES|PERM|EVID}"  
dir=".wt/${lane}"

ts="$(date \-u \+%Y%m%dT%H%M%SZ)"  
ev="${dir}/\_evidence/\_lane/${ts}"  
mkdir \-p "$ev"

(  
  cd "$dir"  
  git status \--porcelain=v1 | tee "${ev}/git\_status.txt"  
  git diff \--stat | tee "${ev}/git\_diffstat.txt"  
  \# 你可以把本 lane 的最小驗收放進來，例如 docs lint / scripts/gates / schema validate 等  
) || true

echo "OK: ${ev}"

---

## **FINAL\_CHECKLIST（Fail-Closed 自檢）**

* v2 100% 覆蓋並可取代 v1（含映射表 §9）  
* 嚴格對齊 Spartoi-OMOC\_開發實作方案 & 工程實作指南 & SSOT（Authority Stack §3）  
* 不造輪子（只用/改輪子；採用 OpenCode/OMOC/GitHub/Scorecard/SLSA 等現成方案）  
* 子代理防遞迴 \+ 最小權限 \+ MCP 外圍鎖 \+ HITL/Kill-Switch（§6.2/§6.3/§7）  
* Evidence/Gates/Schema 可機械判定 PASS/FAIL（§6.5/§6.6/附錄B）  
* 來源索引≥8 \+ URL Registry \+ Delta Log \+ Assumption/Conflict Ledger（§11/§12）  
* Diátaxis 四象限 \+ RAG Header \+ RAG-Triad 評估條款（§2/§6/§10）

---

