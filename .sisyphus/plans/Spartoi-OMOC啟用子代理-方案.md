# **Spartoi-OMOC啟用子代理-方案** ---

 **0\) 封面卡（≤120字）**

**日期：2026-02-05（Asia/Taipei）**  
**一句話結論：你當次主模型其實是 `github-copilot/gpt-5-mini`；OMOC 有「載入+成為主代理」但被 permission ruleset 把 `call_omo_agent` 擋死，所以子代理沒真的跑起來（等同半殘多代理）。**

---

## **1\) 需求對齊（你要的到底是什麼 \+ 我用你給的跡證釘死哪些事）**

### **你的目標（開發期）**

* **啟用 OMOC 子代理**（可驗證：log 出現子代理工具呼叫，且不再 deny）。  
* **只用 Copilot Pro 的低流量/高 CP 值模型組合**，避免亂跳到 `opencode/gpt-5-nano`（可驗證：log 中每個 agent 的 `providerID/modelID` 都是你指定的）。  
* **最小權限白名單**：子代理能工作，但 **bash / 寫檔/危險行為仍被 ask/deny 卡住**（Fail-Closed）。

### **我從你上傳的 log（Spartoi-OMOC實作-7-2.txt）釘死的事實**

* **你當次實際用的模型**：log 明確出現  
  `service=llm agent=sisyphus providerID=github-copilot modelID=gpt-5-mini`（而且還有 `MODEL_USED=github-copilot/gpt-5-mini`）。  
  ⇒ **不是** `opencode/gpt-5-nano`。  
* **OMOC 介入到哪一層**：同一份 log 顯示 `agent=sisyphus`（OMOC 的主代理）在跑，表示 **OMOC 已載入並成為主代理層**；但 permission ruleset 中 **`call_omo_agent` 被設為 deny**，所以 **OMOC 子代理呼叫層被擋**（你看到的 “deny” 不是幻覺，是設定真的這樣寫）。  
* 你看到的 `===== 02_models ===== opencode/...`：那是「**可用模型列表**」，不等於「**已被使用**」。而且你那個 `10┃` 更像是你把輸出做了行號/格式化（不是倍率/費率）。

---

## **2\) 研究摘要（拆 5 個可驗證子題：發現 \+ 洞見 \+ 引文）**

### **子題 A：Copilot Pro 現在有哪些「便宜工作馬」可用？倍率/流量怎麼看？**

* GitHub Docs 已把「**支援模型清單**」與「**model multipliers**」列成表：`GPT-5 mini / GPT-4.1 / GPT-4o / Raptor mini` 在 **付費方案 multiplier=0**（重點：0 代表不吃 premium request 額度或不扣那種加權額度，CP 值高）。([GitHub Docs](https://docs.github.com/copilot/reference/ai-models/supported-models))  
* 同頁也顯示 Raptor mini 是 fine-tuned GPT-5 mini，且 multiplier=0（付費）。([GitHub Docs](https://docs.github.com/copilot/reference/ai-models/supported-models))

洞見：你要的「低流量高 CP 值」組合，**首選就是 multiplier=0 的那幾隻**，不用靠猜。

### **子題 B：為什麼會看到 `opencode/gpt-5-nano`？它是不是偷跑？**

* OpenCode 本身有 **`opencode/` 供應商**，其 Zen 方案主打自家模型與額度；`opencode models` 會列出它可用模型（包含你看到的 `gpt-5-nano` 類）。([OpenCode](https://opencode.ai/docs/zen/))  
* **OMOC 的安裝指南**（repo issue 引用的 guide）明講：在某些條件下（例如以 GitHub Copilot 作為可用 provider），OMOC 預設仍可能把 **Explore agent 指到 `opencode/gpt-5-nano`**。([GitHub](https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/refs/heads/dev/docs/guide/installation.md))

洞見：你看到它出現在 models 清單 **很正常**；真正危險的是「OMOC 預設可能真的拿它當 Explore」。所以要做的是**鎖 provider \+ 覆寫 OMOC agent models**，而不是跟清單吵架。

### **子題 C：為什麼 OMOC 子代理被你自己的 ruleset 擋掉？**

* OpenCode permissions 規則是**可疊加、且「最後匹配優先（last match wins）」**。  
* 你 log 裡的 ruleset 片段顯示 `call_omo_agent` 明確是 deny；因此即使 OMOC 工具有註冊，也會在執行時被權限判斷打回去。

洞見：你現在不是「低效率單代理」，而是「多代理被你自己上銬」——鎖錯位置了。

### **子題 D：最小權限怎麼做才不會放虎歸山？**

* OpenCode 官方 permissions 文件列出可控權限類型（read/write/bash/task/webfetch…），並支援對不同 pattern 做 allow/ask/deny。  
* OMOC repo issue 也指出「背景/遞迴子代理」如果沒限制，可能會亂呼叫 `call_omo_agent`；並提供可行的 restriction 設計方向（針對某些代理禁用 call\_omo\_agent）。([GitHub](https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/refs/heads/dev/docs/guide/installation.md))

洞見：你要的是「主控可叫人、底下的人不能再自己生小孩」——所以 **只放行主代理呼叫**，並在 OMOC agent restriction 裡禁止工人代理再呼叫子代理。

### **子題 E：opencode.json 怎麼鎖「預設模型/供應商」避免每次 \-m？**

* OpenCode 設定檔支援 `model`（預設模型）、`small_model`、以及 `enabled_providers/disabled_providers` 控制供應商可用性。([OpenCode](https://opencode.ai/docs/config/))  
* 插件也是透過 `plugin` 欄位載入。([OpenCode](https://opencode.ai/docs/plugins/))

---

## **3\) 完整方案（可執行）**

### **3.1 架構與流程（ASCII）**

opencode (default model \= gpt-5-mini)  
  └─ plugin: oh-my-opencode (OMOC)  
       ├─ 主代理：sisyphus  (允許 call\_omo\_agent)  
       ├─ 工人：explore / librarian / oracle ... (禁止再 call\_omo\_agent，防遞迴)  
       └─ 權限：task/delegate\_task/call\_omo\_agent 放行；bash/write 仍 ask（Fail-Closed）

### **3.2 低流量模型組合（建議：全數 multiplier=0）**

依 GitHub Docs 的 multipliers，開發期最划算組合如下（你要的「高 CP」）：([GitHub Docs](https://docs.github.com/copilot/reference/ai-models/supported-models))

| 任務性質 | 建議模型（Copilot Pro） | 理由 |
| ----- | ----- | ----- |
| 主控/統籌（sisyphus） | `github-copilot/gpt-5-mini` | 0 倍率工作馬、推進快 |
| 探勘/讀文件/歸納（explore/librarian） | `github-copilot/raptor-mini` | fine-tuned、0 倍率、來回更省 |
| 嚴謹審查/保守修補（oracle / review） | `github-copilot/gpt-4.1` | 0 倍率且更穩健 |
| 多模態（如果需要看圖） | `github-copilot/gpt-4o` | 0 倍率且多模態覆蓋 |

注意：GitHub “Supported models” 頁面會變動（還包含 retirement dates），所以**用文件當真相**、別用記憶硬背。([GitHub Docs](https://docs.github.com/copilot/reference/ai-models/supported-models))

---

## **4\) 風險與對策（偵測 → 緩解 → 備援）**

### **技術風險**

* **風險**：權限規則打架（你現在就同時出現 delegate\_task deny/allow 的混雜）。  
  **偵測**：log 出現 `ruleset=[...] evaluate` 並同一 permission 重複 deny/allow。  
  **緩解**：把 permission 規則改成「單一、可讀、最後匹配明確」。  
  **備援**：先用最小可行白名單（下面模板）跑通「子代理可呼叫」再逐步收緊。  
* **風險**：OMOC 預設把 Explore 指到 `opencode/gpt-5-nano`。  
  **偵測**：log grep 到 `agent=explore providerID=opencode` 或 `opencode/gpt-5-nano`。  
  **緩解**：`enabled_providers=["github-copilot"]` \+ 覆寫 OMOC agent model。([OpenCode](https://opencode.ai/docs/config/))  
  **備援**：如果禁用 opencode provider 導致某些 OMOC 預設失效，就把該 agent 明確改用 `raptor-mini`。

### **營運/成本風險**

* **風險**：子代理遞迴呼叫造成 token 浪費。  
  **偵測**：log 出現 librarian/explore 再呼叫 `call_omo_agent`。  
  **緩解**：對工人代理加 restriction（禁 call\_omo\_agent）。([GitHub](https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/refs/heads/dev/docs/guide/installation.md))  
  **備援**：把 `task` 權限改成 ask（短期），直到確認沒有遞迴。

### **安全風險（你要求的 Fail-Closed）**

* **風險**：bash / 寫檔全放行 → 子代理亂改。  
  **偵測**：log 出現 `permission=bash action=allow` 或 `permission=write action=allow`。  
  **緩解**：bash/write 一律 `ask`（或對特定安全命令 allowlist）。  
  **備援**：把 `external_directory` 改 ask，避免把機器外部路徑當資料外洩管道。

---

## **5\) 來源索引（≥8；去重；標註支撐章節）**

1. GitHub Docs — **Supported AI models in GitHub Copilot**（模型清單、退休資訊、multipliers）([GitHub Docs](https://docs.github.com/copilot/reference/ai-models/supported-models))（支撐：2A/3.2）  
2. GitHub Docs — **Requests in GitHub Copilot**（premium requests/multipliers 說明）([GitHub Docs](https://docs.github.com/en/copilot/concepts/billing/copilot-requests))（支撐：2A/3.2）  
3. OpenCode Docs — **Config**（`model/small_model/enabled_providers/disabled_providers/plugin`）([OpenCode](https://opencode.ai/docs/config/))（支撐：2E/3/附錄）  
4. OpenCode Docs — **Permissions**（權限類型、ask/deny、last match wins）（支撐：2C/2D/4/附錄）  
5. OpenCode Docs — **Plugins**（plugin 機制）([OpenCode](https://opencode.ai/docs/plugins/))（支撐：2E/3）  
6. OpenCode Docs — **models command**（`opencode models` 行為）([OpenCode](https://opencode.ai/docs/cli/))（支撐：2B）  
7. OpenCode Zen — **Plans / 自家模型與額度**（解釋 `opencode/` 供應商存在的合理性）([OpenCode](https://opencode.ai/docs/zen/))（支撐：2B）  
8. OMOC guide（issue 引用的 installation/agent model table，指出 Explore 預設可能是 `opencode/gpt-5-nano`）([GitHub](https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/refs/heads/dev/docs/guide/installation.md))（支撐：2B/3）  
9. OMOC repo issue — **遞迴/背景子代理限制 call\_omo\_agent 的需求與方向**([GitHub](https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/refs/heads/dev/docs/guide/installation.md))（支撐：2D/4）

---

## **6\) 附錄（設定檔範例 \+ 驗證命令 \+ 一條 opencode 指令）**

你要的三件事：  
**(1) 子代理確實被呼叫（不再 deny）**、**(2) 子代理模型是你指定的便宜模型**、**(3) bash/write 仍被 ask/deny 卡住**。下面給你「配置 \+ 驗證」直接釘死。

### **6.1 `opencode.json`（專案根目錄）範本：啟用 OMOC \+ 鎖 Copilot \+ 最小權限**

依 OpenCode Config/Permissions 規格（含 enabled/disabled providers、plugin、permission）。([OpenCode](https://opencode.ai/docs/config/))

{  
  "$schema": "https://opencode.ai/config.json",

  // 啟用 OMOC  
  "plugin": \["oh-my-opencode@latest"\],

  // 預設模型：主工作馬（0 multiplier）  
  "model": "github-copilot/gpt-5-mini",  
  "small\_model": "github-copilot/raptor-mini",

  // 只開 Copilot，避免 OMOC/系統預設飄去 opencode/\*  
  "enabled\_providers": \["github-copilot"\],  
  "disabled\_providers": \["opencode", "openai", "anthropic", "google", "xai", "zai"\],

  // Fail-Closed：bash/write 仍 ask；但放行多代理呼叫所需的 task/delegate\_task/call\_omo\_agent  
  // 規則：last match wins（順序很重要）:contentReference\[oaicite:25\]{index=25}  
  "permission": \[  
    { "permission": "\*", "action": "allow", "pattern": "\*" },

    // 讀取允許；敏感 env 類 ask  
    { "permission": "read", "action": "allow", "pattern": "\*" },  
    { "permission": "read", "action": "ask", "pattern": "\*.env" },  
    { "permission": "read", "action": "ask", "pattern": "\*.env.\*" },  
    { "permission": "read", "action": "allow", "pattern": "\*.env.example" },

    // 網路抓取（若你開發期需要查資料）— 仍建議保留 allow，但靠 bash/write ask 來封住落地動作  
    { "permission": "webfetch", "action": "allow", "pattern": "\*" },

    // 多代理必需：允許啟動 task / delegate / OMOC 子代理工具  
    { "permission": "task", "action": "allow", "pattern": "\*" },  
    { "permission": "delegate\_task", "action": "allow", "pattern": "\*" },  
    { "permission": "call\_omo\_agent", "action": "allow", "pattern": "\*" },

    // 風險行為：一律 ask（你要的 Fail-Closed）  
    { "permission": "bash", "action": "ask", "pattern": "\*" },  
    { "permission": "write", "action": "ask", "pattern": "\*" }  
  \]  
}

### **6.2 `.opencode/oh-my-opencode.jsonc`：把 OMOC 子代理模型全覆寫成「Copilot 0 倍率組合」+ 防遞迴**

依 OMOC issue 的 restriction 思路：工人代理禁用 `call_omo_agent`，避免遞迴生娃。([GitHub](https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/refs/heads/dev/docs/guide/installation.md))

{  
  "agents": {  
    "sisyphus": {  
      "model": "github-copilot/gpt-5-mini"  
    },

    "explore": {  
      "model": "github-copilot/raptor-mini",  
      "restriction": { "call\_omo\_agent": false }  
    },

    "librarian": {  
      "model": "github-copilot/raptor-mini",  
      "restriction": { "call\_omo\_agent": false }  
    },

    "oracle": {  
      "model": "github-copilot/gpt-4.1",  
      "restriction": { "call\_omo\_agent": false }  
    },

    "multimodal-looker": {  
      "model": "github-copilot/gpt-4o",  
      "restriction": { "call\_omo\_agent": false }  
    }  
  }  
}

### **6.3 驗證命令：用 log 釘死「子代理有跑 / 沒飄模型 / bash/write 仍被擋」**

下面指令假設你在 Codespaces repo 根目錄執行，並把 log 落到 `_evidence/_omoc_verify/`。

ts="$(date \-u \+%Y%m%dT%H%M%SZ)"  
out="\_evidence/\_omoc\_verify/$ts"  
mkdir \-p "$out"

\# 1\) 觸發一次「必定會呼叫子代理」的任務（讓主代理明確 call\_omo\_agent）  
opencode \--log-level DEBUG \--print-logs run \\  
"你必須做兩步：  
(1) 立即呼叫 call\_omo\_agent：讓 librarian 列出本 repo 的前 30 個檔案路徑並分 5 類；  
(2) 再呼叫 call\_omo\_agent：讓 explore 找出 repo 內最重要的 3 個入口文件並各用一句話說明用途。  
最後只輸出：DONE。" \\  
\> "$out/run.stdout.log" 2\> "$out/run.stderr.log"  
echo $? \> "$out/run.exit\_code.txt"

\# 2\) 釘死：子代理確實被呼叫（不再 deny）  
grep \-nE "tool=call\_omo\_agent|permission=.\*call\_omo\_agent.\*action=" \-n "$out/run.stderr.log" \\  
  \> "$out/grep.call\_omo\_agent.txt" || true

\# 3\) 釘死：每個 agent 實際使用的 provider/model（而不是嘴上說）  
grep \-nE "service=llm .\*agent=.\* providerID=.\* modelID=" "$out/run.stderr.log" \\  
  \> "$out/grep.llm\_models.txt" || true

\# 4\) 釘死：沒有飄去 opencode/gpt-5-nano  
grep \-nE "providerID=opencode|opencode/gpt-5-nano" "$out/run.stderr.log" \\  
  \> "$out/grep.opencode\_model\_hits.txt" || true

\# 5\) 釘死：bash/write 仍是 ask/deny（Fail-Closed）  
opencode \--log-level DEBUG \--print-logs run \\  
"請嘗試執行 bash: echo HELLO\_OMOC （這應該被 ask/deny 擋下），然後回報你是否被阻擋。" \\  
\> "$out/askprobe.stdout.log" 2\> "$out/askprobe.stderr.log"  
echo $? \> "$out/askprobe.exit\_code.txt"  
grep \-nE "permission=bash|permission=write|action=ask|action=deny" "$out/askprobe.stderr.log" \\  
  \> "$out/grep.ask\_deny\_proof.txt" || true

#### **你該怎麼判讀 PASS/FAIL（不用靠感覺）**

* **子代理有跑（PASS）**：`$out/grep.call_omo_agent.txt` 內看得到 `tool=call_omo_agent event=started`（或至少有 allow 的 permission 決策）；而不是只有 ruleset 列表。  
* **模型沒亂跳（PASS）**：`$out/grep.llm_models.txt` 裡所有 agent 都是 `providerID=github-copilot`，且 `modelID` 是你配置的那幾個（gpt-5-mini / raptor-mini / gpt-4.1 / gpt-4o）。  
* **沒用到 opencode/gpt-5-nano（PASS）**：`$out/grep.opencode_model_hits.txt` 應該是空的（或只有 models 清單，不應出現在 llm 呼叫）。  
* **bash/write 仍被擋（PASS）**：`$out/grep.ask_deny_proof.txt` 內出現 `permission=bash ... action=ask/deny`。

---

### **6.4 你問的兩個問題：直球裁決（不拐彎）**

1. **「所以我現在不是多代理，而是單代理嗎？」**  
   就你目前 log 的 `call_omo_agent: deny` 來看：**OMOC 子代理層確實沒跑起來**，所以你得到的是「主代理在自言自語」的體驗（多代理被你自己封印）。要解封，就照上面把 `call_omo_agent` 放行並用 restriction 防遞迴。  
2. **「能否用 Copilot Pro 低流量模型組合啟用 OMOC 子代理？」**  
   可以，而且你要的那幾隻（`gpt-5-mini / gpt-4.1 / raptor-mini / gpt-4o`）在 GitHub Docs 的 multipliers 表裡對付費方案都是 **0 倍率**，正是“高 CP 值”那一群。([GitHub Docs](https://docs.github.com/copilot/reference/ai-models/supported-models))

---

如果你把 **6.1/6.2 套上去**再跑 **6.3 驗證**，你就能用「log 證據」回答你最在意的兩件事：

* **OMOC 子代理到底有沒有真的出手**（而不是只在工具列表裡露臉）。  
* **每一次出手到底用的是哪個 provider/model**（而不是 models 清單上誰坐在候補席）。

