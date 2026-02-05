# **任務交接報告｜Spartoi-OMOC 工程實作指南「落地 & 驗收」（Codespaces）— 2026-02-04**

目的：讓新對話的 GPT **不需要回頭翻對話**，即可接手並繼續完成《Spartoi-OMOC 工程實作指南》的後續「全量落地 \+ 全驗收」工作。  
原則：**Fail-Closed（無證據不宣判）**；以 repo 與 CI 證據為準。

---

## **0\) 權威堆疊與本次交接範圍**

### **0.1 權威堆疊（Authority Stack）**

* **A0**：《Spartoi-OMOC 工程實作指南》為最終準則（Definition of Done / GateKit / 15 CA Stations / Evidence Trinity 等）。  
* **A1**：《OMOC-GMA Lite 實作指南\_任務交接報告\_02042143》作為既有進度與已落地內容依據（尤其是 CI/證據鏈與常見阻塞）。  
* **A3**：Repo 現況（git/CI/rulesets）為唯一可信事實來源。

### **0.2 本次交接「已完成」的範圍（截至 2026-02-04）**

已完成的是 **B1 最小可驗證切片（Minimal Verifiable Slice）**：

* 控制面（Rulesets \+ required checks）可用  
* CI（quality-gates）可用  
* acceptance 入口（scripts/acceptance.sh）在 Codespaces main 分支 **可 PASS**  
* Evidence/Trinity 觀念與工件（至少在 CI artifact 內）存在、可追溯  
  但「全量 DoD」尚未達成（見 §6）。《指南》明確定義「合法 DoD」＝控制面工程化 \+ 全 CA 工作站可跑 \+ 驗收閉環 PASS \+ EXECUTE 鎖定（HITL/Kill-Switch）。

---

## **1\) Repo 與治理狀態（硬證據摘要）**

### **1.1 Repo**

* Repo：`shw097/spartoi-project-2`  
* PR \#9：`feat(b1): minimal GateKit + acceptance entrypoint`（已 squash merge 到 `main`）

### **1.2 Rulesets（治理）**

* 目前只有 1 個 active ruleset：`fail-closed-gates`（其餘 disabled）。  
* ruleset 的詳細內容（已由 `GET /repos/{owner}/{repo}/rulesets/{ruleset_id}` 方式抓取）是確認治理規則的正規做法。([GitHub Docs](https://docs.github.com/en/rest/repos/rules?utm_source=chatgpt.com))

註：若未來啟用 Merge Queue，必須把 workflow 加上 `merge_group` 事件，否則 merge queue 階段 required checks 會永遠 pending。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))

---

## **2\) CI / 驗收證據鏈（可追溯）**

### **2.1 CI Workflow**

* workflow：`quality-gates`

### **2.2 關鍵 runs（本次任務中曾反覆失敗 → 最終成功）**

* PR 分支（`spartoi/b1-minslice-20260204T140645Z`）曾多次 failure，最終成功：  
  * `21675514355`（success；並產出 artifact `b1-evidence`，內含 evidence/\_b1 三件套與 logs）  
  * `21675523669`（success）  
* main 分支 push 成功（重要：main 的 required checks 綠燈鏈）：  
  * `21675989911`（push main，success）

（歷史 run 列表輸出可參考你先前貼回內容；新對話 GPT 若要重拉，請用 §4.1 的命令。）

### **2.3 為什麼曾出現「Fail-Closed：log not found」**

* `gh run view` 在某些情境下會因平台限制導致 log 對應失敗；GitHub CLI 手冊明示「可能無法關聯 job logs」，並會 fallback；缺 log 時不得宣判 PASS。([GitHub CLI](https://cli.github.com/manual/gh_run_view?utm_source=chatgpt.com))

---

## **3\) 本地（Codespaces）驗收：已 PASS，但證據被 .gitignore 忽略**

### **3.1 成功的本地驗收證據**

* 在 `main` 執行 `scripts/acceptance.sh` 已 **PASS**，並落在：  
  * `evidence/_acceptance/20260204T150644Z/acceptance_console.txt`  
  * `evidence/_acceptance/20260204T150644Z/exit_code.txt`（值為 0）

### **3.2 終端「會終止」的根因與修復**

* 根因：先前版本命令在最後 `exit "${EC}"`，會把 interactive shell 直接關掉（常被誤會成“終端崩潰”）。  
* 已採用「安全版」：不 `exit`，只印 exit code \+ 證據路徑。

### **3.3 為何無法 `git add evidence/...`**

* repo 的 `.gitignore` 忽略了 `evidence/`，因此 `git add evidence/_acceptance/...` 會被擋（除非 `git add -f`）。  
* 這是策略問題：**證據應走 CI artifact / evidence index（可稽核）**，或只例外允許少量摘要檔（建議見 §7.3）。

---

## **4\) 可重放的關鍵命令（新對話 GPT 直接沿用）**

### **4.1 Preflight / 取證（不依賴 UI）**

**（A）列 rulesets 摘要 \+ 逐個抓 detail（必要：確認是否有 merge queue / required checks）**

set \-u  
OWNER\_REPO="$(gh repo view \--json nameWithOwner \-q .nameWithOwner)"

gh api \-H "Accept: application/vnd.github+json" "repos/${OWNER\_REPO}/rulesets" \--paginate \\  
  | jq \-c '.\[\] | {id,name,enforcement,target}'

for id in $(gh api \-H "Accept: application/vnd.github+json" "repos/${OWNER\_REPO}/rulesets" \--paginate | jq \-r '.\[\].id'); do  
  echo "---- ruleset ${id} \----"  
  gh api \-H "Accept: application/vnd.github+json" "repos/${OWNER\_REPO}/rulesets/${id}" \\  
    | jq '{id,name,enforcement,target,conditions,rules,bypass\_actors}'  
done

（Rulesets REST API：([GitHub Docs](https://docs.github.com/en/rest/repos/rules?utm_source=chatgpt.com))）

**（B）列最近 runs（避免欄位錯位）**

gh run list \--limit 20 \--json databaseId,workflowName,event,headBranch,status,conclusion,url \\  
  | jq \-r '.\[\] | "\\(.workflowName)\\t\\(.event)\\t\\(.headBranch)\\t\\(.status)\\t\\(.conclusion)\\t\\(.url)"'

（`gh run list` 手冊：([GitHub CLI](https://cli.github.com/manual/gh_run_list?utm_source=chatgpt.com))）

### **4.2 Codespaces 本地驗收（安全版；不會關終端）**

set \-u

git checkout main  
git pull \--ff-only origin main

TS="$(date \-u \+%Y%m%dT%H%M%SZ)"  
OUT="evidence/\_acceptance/${TS}"  
mkdir \-p "${OUT}"

bash scripts/acceptance.sh \>"${OUT}/acceptance\_console.txt" 2\>&1  
EC=$?  
echo "${EC}" \> "${OUT}/exit\_code.txt"

echo "ACCEPTANCE\_EXIT\_CODE=${EC}"  
echo "ACCEPTANCE\_EVIDENCE\_DIR=${OUT}"

if \[ "${EC}" \-eq 0 \]; then  
  echo "ACCEPTANCE: PASS"  
else  
  echo "ACCEPTANCE: FAIL (see ${OUT}/acceptance\_console.txt)"  
fi

### **4.3 merge\_group 掃描（不用 rg 也能做）**

grep \-RIn "merge\_group" .github/workflows || true

若未來啟用 merge queue：workflow 必須支援 `merge_group`，GitHub 文件明確要求。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))

---

## **5\) 已落地的「指南關鍵構件」對照表（索引）**

下列為本次已建立/已驗證的「骨架能力」，用來承接指南的後續全量工作。

### **5.1 GateKit / GateRunner / Trinity（概念與工件）**

* **GateKit：8 Gate 模板**在指南有固定清單（G-SRC / G-SCHEMA / G-BT-H / G-SEG-L / G-CONF-L / G-XQ-PARITY / G-HITL-LOG / G-RUN）。  
* **The Trinity（三件套）**：`inputs_manifest.json`、`evidence_manifest/evidence_index.json`、`verdict.json`；缺一即 Fail-Closed；且 `verdict.json` **必須 deterministic code 生成，嚴禁 LLM 生成**。  
* MVP Spine 範例亦明示 8 gate 的模板結構，可作為對照樣張索引。

### **5.2 執行平面（OMOC/OpenCode）應走的路徑**

* 指南要求 OpenCode CLI \+ `opencode.json` 配置、Codespaces `.devcontainer` 固化、4-lanes agents（Spec/Dev/Ops/Vibe）。

---

## **6\) 尚未完成（不能宣稱 100%）— 依《指南》DoD 的缺口清單**

《指南》合法 DoD＝「控制面工程化 \+ 全 CA 工作站可跑 \+ 驗收閉環 PASS \+ EXECUTE 鎖定  
目前缺口（至少）：

1. **15 CA 工作站全量落地**（各 CA 目錄、`task_manifest.yaml`/adapter/I/O 合約）  
2. **station.config.yaml / task manifest 的參數化驅動**（Orchestrator→Dispatcher→Loader→Runner）  
3. \*\*HI（涉及資金操作必須人工確認，禁止無人值守）  
4. **GateKit 8 templates 的工程化落地與綁定覆蓋（非僅概念）**：目前是 B1 切片；尚未達「全站點覆蓋 \+ 全 gate binding」

---

## **7\) 風險、坑點與既定修法（Fail-Closed 版）**

### **7.1 常見坑（已遇到）**

* **終端“自殺”**：`exit` / `set -e` 連鎖；修法：捕捉 exit code、先落 evidence、最後  
* **gh 取 log 不穩**：`gh run view` 可能拿不到完整 logs；Fail-Closed 下只能以「run 結論([GitHub CLI](https://cli.github.com/manual/gh_run_view?utm_source=chatgpt.com))  
* **merge queue 假象**：PR 綠 ≠ merge queue 綠；merge queue 需要 `merge_group`。([GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue?utm_source=chatgpt.com))

### **7.2 策略性風險（尚未處理）**

* evidence 目前被 `.gitignore` 忽略：若未建立「摘要可版本控管」的策略，長期稽核只能依 CI artifact。

### **7.3 建議的 evidence 保存策略（最小改動）**

* 維持 `evidence/` 忽略（避免 repo 膨脹），但**例外允許摘要/索引**被 commit（例如：`evidence_index.json`、`verdict.json`、`exit_code.txt` 等，依實際契約挑選）。  
* 目的：在不污染 repo 的前提下，仍能做到「可稽核、可追溯」。

---

## **8\) 下一步任務拆包（給新對話 GPT 的執行路線圖）**

目標：把目前 B1 切片推進到《指南

### **WP-Next-01｜建立 15 CA Stations 的最小骨架（目錄 \+ manifest \+ adapter stub）**

* 依指南 §4 的標準結構逐站生成：`task_manifest.yaml`、`adapters/`、I/O 契約（inputs\_manifest→evidence\_manifest→verdict）。

### **WP-Next-02｜導入 station.config.yaml 參數化編排（單一流水線 / matrix / reusable workflow）**

* 目標：用 GitHub Matrix/Reusable Workflows，而不是自研 DSL（指南方案 B）。

### **WP-Next-03｜HITL/Kill-Switch 鎖定（EXECUTE 禁止自動下單）**

* 明確把 “RADAR\_ONLY/EXECUTE\_DISABLED” 寫入 inputs\_manifest，並落 `hitl_handoff.json` gate/日志；不符即 Fail-Closed。

### **WP-Next-04｜GateKit 8 templates 實作化 \+ 綁定覆蓋（全站點 gate\_binding）**

* 由 gate\_binding 驅動 GateRunner；產出 deterministic verdict。

---

## **9\) 記憶碼 / 索引（讓新對話 GPT 快速定位）**

### **oD（合法/非法定義）\*\*：控制面工程化 \+ 全 CA 工作站 \+ 驗收閉環 PASS \+ EXECUTE 鎖定；禁止無人值守資金操作。**

* **GateKit 8 模板清單**：G-SRC / G-SCHEMA / G-BT-H / G-SEG-L / G-CONF-L / G-XQ-PARITY / G-HITL-LOG / G-RUN  
* **Trinity（三件套）與 deterministic verdict**：缺一 Fail-Closed；verdict 必須 deterministic code 生成。  
* **station.config.yaml / task manifest 驅動**：Orchestrator→Dispatcher→Loader→Runner。

### **9.2 本次會話關鍵 Run IDs / PR**

* PR：`#9`（已合併）  
* CI runs（示例）：  
  * PR 成功：`21675514355`、`21675523669`  
  * main push 成功：`21675989911`

### **9.3 本地驗收證據（被 .gitignore 忽略）**

* `evidence/_acceptance/20260204T150644Z/*`（Codespaces main PASS）

---

## **FINAL\_ACCEPTANCE\_SUMMARY（交接點裁決：Fail-Closed）**

FINAL\_ACCEPTANCE\_SUMMARY  
SCOPE: B1 minimal verifiable slice \+ governance green chain \+ local acceptance proof :contentReference\[oaicite:36\]{index=36}s PASS (with evidence):  
\- Codespaces local acceptance on main: exit\_code=0, evidence written under evidenc:contentReference\[oaicite:37\]{index=37}po ignores evidence/, but local proof exists)  
\- CI quality-gates has successful runs for PR branch and main push (run IDs recorded in this report)  
\- Workflow includes merge\_group trigger support (future-proof if merge queue is enabled)  (GitHub requires merge\_group for merge queue checks)

🔗 Governing references:  
\- Merge queue requires merge\_group event to trigger required checks. :contentReference\[oaicite:38\]{index=38}  
\- Rulesets detail must be fetched via rulesets REST API endpoints. :contentReference\[oaicite:39\]{index=39}  
\- gh run list / gh run view behavior and limitations. :contentReference\[oaicite:40\]{index=40}

📁 Repo/Workspace evidence paths (current state):  
\- Local: evidence/\_acceptance/20260204T150644Z/acceptance\_console.txt  
\- Local: evidence/\_acceptance/20260204T150644Z/exit\_code.txt  
\- CI: b1-evidence artifact (from successful PR run; contains evidence/\_b1: verdict.json, triad.json, evidence\_index.json, etc.)

🧾 What is NOT yet 100% (blocking “full DoD”):  
\- 15 CA stations not fully implemented and runnable end-to-end as per Spartoi-OMOC guide.  
\- station.config.yaml/task manifest parameterized orchestration not fully landed for all stations.  
\- EXECUTE lock (HITL/Kill-Switch) engineering enforcement not fully proven across pipelines.  
\- GateKit 8 templates \+ gate\_binding coverage not fully proven across all stations.

---

以上報告即為新對話 GPT 的「可接手狀態」。如果你要我再把 §8 的 WP-Next-01\~04 直接升級成「B0 台帳（Markdown 表 \+ JSON）」並附一條 opencode 多代理一鍵指令（自動落地→跑驗收→失敗自動修補→直到 PASS），新對話 GPT 會以本報告為起點直接推進。

