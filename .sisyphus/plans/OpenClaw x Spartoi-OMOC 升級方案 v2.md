# OpenClaw x Spartoi-OMOC 升級方案 v2

## ---

 **0\) 封面卡（≤120字）**

**任務摘要**：以 **OpenCode/OMOC 作控制面主骨架**，把 OpenClaw 的「隔離/分流/掃描」三技巧收編進 Spartoi 的 GateRunner＋Evidence＋Schema 治理，並把 OpenClaw 鎖在 **MCP allowlist＋隔離執行** 的外圍層。  
**日期**：2026-02-05（Asia/Taipei）  
**主要結論**：**不是二選一**；最佳是「**單一主控骨架 \+ 三技巧吸收 \+ 外圍硬護欄**」，才能同時快、低人工、可驗證、且不造輪子。

---

## **1\) 需求對齊（你給的硬約束我逐條上鎖）**

### **目標（你要的）**

* 更快落地、更低人工、更高自動化/自進化、更高效率/性能。  
* **100% 不造輪子**（允許改輪子、組裝輪子、加護欄）。  
* **必須“可驗證”地支援/升級 Spartoi-OMOC 各子系統**（以 SRS/ARCH/ICD/RUNBOOK 條款判定；Fail-Closed）。

  ### **不可違反（你明說＋Spartoi精神）**

* **控制面主權在 Spartoi（SRS/ARCH/ICD/RUNBOOK）**；OpenClaw 不能變成新的控制面。  
* **不做自動下單**：任何會導向 P2（自動交易/自動執行）的一律要被 Gate 卡死（HITL/Kill-Switch）。  
* OpenClaw 只能走 **MCP \+ allowlist \+ 隔離執行**；ClawHub skills 預設 **NO-GO**。  
  ---

  ## **2\) 研究摘要（含交叉比對：OpenClaw 建議 vs 我方案；並指出你關心的“是否有疏漏”）**

你要的是「**更快** \+ **更穩** \+ **可驗證**」，而不是“更熱鬧”。所以我先把會讓你**提速**、也會讓你**爆炸**的點列清楚。

### **子題 A｜OpenCode/OMOC 能否當 Spartoi 的“主控骨架”？**

* OpenCode 原生就有 **opencode.json / JSONC** 設定合併與覆蓋、可設定 **permissions（bash/edit ask）**、可控 **tools 開關**、可掛 **MCP servers**、可載入 **plugins**。這些剛好對應 Spartoi 的“控制面治理/硬護欄”。([opencode.ai](https://opencode.ai/docs/config/))  
* OMOC 的定位是「OpenCode 的 orchestration layer」：用“現成編排層”去做多代理工作流，符合你要的“不造輪子（用輪子）”。([ohmyopencode.com](https://ohmyopencode.com/))  
* **實務結論**：OpenCode/OMOC 非常適合做 Spartoi-OMOC 的 **P1 控制面骨架**，因為你要的其實是“治理＋驗收閉環”的自動化，而不是再發明一套 orchestrator。([opencode.ai](https://opencode.ai/docs/config/))

  ### **子題 B｜OpenClaw「三技巧」到底值不值得吸收？（workspace隔離 / 模型分流 / 任務後掃描）**

* **workspace / memory 隔離**：對多代理最常見的災難（上下文污染、跨任務滲透）是有效解法；但要**被 Spartoi 的 Evidence/Gate 化**，否則只是“看起來很乾淨”。  
* **模型分層調度**：能提速與降成本，但**必須服從 Spartoi 模型政策**；不符合就只能當 optional（不進主路徑）。  
* **任務後自動掃描**：這個最值錢，因為它能把“自進化”變成**可驗證的回饋迴路**（掃描→證據→Gate→修補PR）。  
* **關鍵差異點（你問我方案 vs OpenClaw 建議）**：  
  * *OpenClaw-centric* 的寫法常會默認「工具/skills 可直接跑」；  
  * *Spartoi-centric* 必須把它變成「**掃描結果＝證據包的一部分**，並進 Gate」。  
* **你追問的“是否代表我先前提取有疏漏？”答案**：  
  * **不是漏掉核心方向**，而是先前方案把三技巧當“可行最佳實務”，但**沒有把它們具體編進 Gate/Evidence 的主路徑條款**。  
  * 你現在要的是“條款級可驗證”，所以 v2 會把三技巧變成**有產物、有證據、有門檻**的硬件，而不是口號。

  ### **子題 C｜為什麼我堅持「OpenClaw 必須被 MCP/allowlist/隔離」？**

* MCP 生態在 2025–2026 出現多起**結構性風險**：研究指出 MCP 缺乏足夠的 context-tool isolation 與 least-privilege，會放大「寄生工具鏈/隱私外洩」類攻擊面。([AIセキュリティポータル](https://aisecurity-portal.org/en/literature-database/mind-your-server-a-systematic-study-of-parasitic-toolchain-attacks-on-the-mcp-ecosystem/))  
* Backslash 的實測掃描顯示不少 MCP servers 存在**網路暴露（0.0.0.0）與過度權限/OS injection**等高風險組合（他們稱 NeighborJack 等）。([backslash.security](https://www.backslash.security/blog/hundreds-of-mcp-servers-vulnerable-to-abuse))  
* 另有工具層面漏洞：例如 MCP Inspector 曾出現 **authorization bypass（CVE-2025-49596）** 這類安全事件，代表“把 MCP 當內網可信”是很危險的直覺。([Claude API Docs](https://docs.anthropic.com/en/docs/mcp))  
* 你要的又是 **ClawHub skills 預設 NO-GO**：因為市場型 skills 被證實可能出現惡意/供應鏈問題（有資安報導指向惡意 skills 風險）。([docs.openclaw.ai](https://docs.openclaw.ai/skills))

  ### **子題 D｜「不造輪子」怎麼把“自進化”做成工程閉環？**

* 用現成輪子：**Conftest/OPA** 做 policy-as-code（驗規格/護欄）；([GitHub](https://github.com/actions/attest-build-provenance))  
* 用現成輪子：**Sigstore/cosign** 做簽章與驗證；([Sigstore](https://docs.sigstore.dev/cosign/verifying/verify/))  
* 用現成輪子：**SLSA provenance** 與 GitHub 的 artifact attestation，把“產物從哪來”變成可追溯證據。([SLSA](https://slsa.dev/provenance))  
  ---

  ## **3\) 完整方案（可執行）：OpenClaw x Spartoi-OMOC 升級方案 v2**

  ### **3.1 架構與流程（單骨架 \+ 三技巧吸收 \+ 外圍硬護欄）**

* \[Dev/CI Trigger\]  
*    |  
*    v  
* \[OpenCode Runtime\]  \<-- Spartoi-OMOC 控制面主控（唯一主控）  
*    |  (OMOC orchestration via plugin)  
*    v  
* \[OMOC Spine: agents/hooks/workflows\]  
*    |  
*    \+--\> \[CA Workspace \#1\]  (隔離：工作目錄+記憶/輸入集)  
*    \+--\> \[CA Workspace \#2\]  (隔離)  
*    ...  
*    \+--\> \[CA Workspace \#N\]  (隔離)  
*    |  
*    \+--\> \[Post-task Scan Pack\]  (掃描=證據=Gate輸入)  
*    |  
*    v  
* \[GateRunner \+ Evidence Bundle \+ Schema Validation\]  
*    |  
*    \+--\> PASS \-\> merge queue / release gates  
*    \+--\> FAIL \-\> 自動產生修補PR（仍走 required checks）  
*    |  
*    v  
* \[OpenClaw (外圍層)\] 只能走 MCP server \+ allowlist \+ sandbox  
*    (ClawHub skills 預設 NO-GO；需要走白名單/簽章/審核)


  ### **3.2 工具鏈（全部用現成輪子；你只寫 glue/設定）**

**主骨架（必選）**

* OpenCode config：用 `permission` 把危險操作改成 `ask`；必要時直接關掉 `tools.write/tools.bash`。([opencode.ai](https://opencode.ai/docs/config))  
* OMOC：用 plugin/agents/hooks 直接拿現成多代理工作流。([ohmyopencode.com](https://ohmyopencode.com/))

**三技巧吸收（變成“可驗證硬件”）**

1. **每 CA workspace / memory 隔離**  
   * 作法：每個 CA 以獨立工作目錄、獨立輸入集、獨立產物集運行；CI 用矩陣 job 或分段 workflow。  
   * 驗證：Gate 內新增 `isolation_report.json`（列出 CA workspace、輸入清單 hash、輸出清單 hash）。  
2. **模型分層調度（受 Spartoi 模型政策約束）**  
   * 作法：OpenCode 支援 per-project config 合併；把“快模型/慢模型”做成 profile（例如 dev / verify / audit）。([opencode.ai](https://opencode.ai/docs/config/))  
   * 驗證：Gate 輸出 `model_routing_proof.json`（每步驟使用模型、policy 判定結果）。  
   * 若與 Spartoi 模型政策衝突：**標記 Optional，不進主路徑**（Fail-Closed）。  
3. **任務後自動掃描（必進 Gate）**  
   * 作法：固定跑一組掃描（policy/secret/supply-chain/MCP exposure），掃描輸出全部落 Evidence。  
   * 驗證：Gate 必須讀得到 `scan_report.json` 並判斷 PASS/FAIL。

**外圍硬護欄（OpenClaw 只能當“帶腳鐐的工具手臂”）**

* OpenClaw 透過 OpenCode 的 **MCP servers** 掛載，但只開白名單工具（allowlist）。([opencode.ai](https://opencode.ai/docs/config/))  
* MCP 安全基線：  
  * 禁止 0.0.0.0 暴露（避免 NeighborJack 類問題）。([backslash.security](https://www.backslash.security/blog/hundreds-of-mcp-servers-vulnerable-to-abuse))  
  * 最小權限、工具級 allowlist、敏感資料遮罩；研究指出缺乏隔離會導致寄生工具鏈/隱私外洩。([AIセキュリティポータル](https://aisecurity-portal.org/en/literature-database/mind-your-server-a-systematic-study-of-parasitic-toolchain-attacks-on-the-mcp-ecosystem/))  
  * 避免/修補已知工具漏洞（例如 Inspector auth bypass 類事件）。([Claude API Docs](https://docs.anthropic.com/en/docs/mcp))  
* ClawHub skills：**預設 NO-GO**（供應鏈風險）；若要用，必須「來源可稽核＋簽章/哈希鎖＋沙箱＋掃描證據進 Gate」。([docs.openclaw.ai](https://docs.openclaw.ai/skills))

  ### **3.3 Coverage Map（可驗證、Fail-Closed）—你要的“完美支援”我用可判定定義**

我不會用“完美”這種無法驗證的形容詞糊弄你；我把它改成**可判定的 Coverage 條款**。

**Coverage 條款（每個 CA 都要滿足）**

* C0：該 CA 有 `station.config.yaml`（或等價配置）與最小運行入口（能跑 GateRunner）。  
* C1：能產生完整 **Evidence Bundle**（至少含：輸入清單、輸出清單、掃描報告、Gate verdict）。  
* C2：Schema 驗證 PASS（ICD 定義的 manifest/schema）。  
* C3：Policy gates PASS（SRS 定義的阻斷/警告政策）。  
* C4：若涉及 P2/交易/外部副作用 → **必須 EXECUTE\_DISABLED \+ HITL/Kill-Switch 生效**（Fail-Closed）。  
* C5：OpenClaw 若參與 → 只允許 MCP allowlist 工具，並附 sandbox/掃描證據。

**你要的“表格化 Coverage Map”交付方式（不造輪子版本）**

* 由於你要求“條款級可驗證”，我建議把 coverage map **做成自動產物**：  
  1. 讀 ARCH 抽出 CA 列表（15 個 CA）。  
  2. 逐 CA 檢查 C0–C5。  
  3. 輸出 `evidence/_meta/coverage_map.md` \+ `evidence/_meta/coverage_map.json`。  
* 這不是造輪子：你只是用現成 CLI（rg/jq）或最小腳本把“真相”吐出來，避免人工抄表造成幻覺。

**一鍵產生 Coverage Map（示例，貼上即跑）**

* set \-euo pipefail  
*   
* \# 1\) 抓 CA 清單（以 ARCH 為準：請把路徑替換成你 repo 內實際檔名）  
* ARCH\_FILE="docs/Spartoi｜P1\_ARCH\_v6.0.0-r5.md"  
* CA\_LIST=$(rg \-o "CA-\[A-Z0-9\_-\]+" \-N "$ARCH\_FILE" | sort \-u)  
*   
* mkdir \-p evidence/\_meta  
*   
* \# 2\) 逐 CA 檢查最小覆蓋（你可再加：ICD schema 驗證、GateRunner 執行）  
* {  
*   echo "| CA | C0 config | C1 evidence | C2 schema | C3 policy | C4 execute-disabled | C5 mcp-allowlist |"  
*   echo "|---|---|---|---|---|---|---|"  
*   for ca in $CA\_LIST; do  
*     cfg="stations/$ca/station.config.yaml"  
*     evd="evidence/$ca"  
*     has\_cfg=$(\[ \-f "$cfg" \] && echo "✅" || echo "❌")  
*     has\_evd=$(\[ \-d "$evd" \] && echo "✅" || echo "❌")  
*     \# 下面四項先以占位符示意：應改成你 GateRunner/Schema/Policy 的真實檢查結果  
*     echo "| $ca | $has\_cfg | $has\_evd | ⏳ | ⏳ | ⏳ | ⏳ |"  
*   done  
* } \> evidence/\_meta/coverage\_map.md  
*   
* echo "OK: wrote evidence/\_meta/coverage\_map.md"


  ### **3.4 禁區清單（No-Go List）—“你想快，先別撞牆”**

**控制面/治理禁區**

* ❌ **任何形式的自動下單/自動交易執行**（P2 行為）不得進主路徑；只能輸出建議與證據，並由 HITL/Kill-Switch 掌控。  
* ❌ 讓 OpenClaw 變成主 orchestrator（控制面主權漂移）。  
* ❌ 允許模型或工具跳過 GateRunner / Evidence Bundle（無證據不通行）。

**MCP / OpenClaw 安全禁區**

* ❌ MCP server 綁 0.0.0.0 或可被同網段任意訪問（NeighborJack/暴露面）。([backslash.security](https://www.backslash.security/blog/hundreds-of-mcp-servers-vulnerable-to-abuse))  
* ❌ 未做 allowlist 就放行任意 tools/skills（最小權限失效）。([AIセキュリティポータル](https://aisecurity-portal.org/en/literature-database/mind-your-server-a-systematic-study-of-parasitic-toolchain-attacks-on-the-mcp-ecosystem/))  
* ❌ 直接啟用 ClawHub skills（預設 NO-GO）；若要用必須供應鏈/掃描/證據全套。([docs.openclaw.ai](https://docs.openclaw.ai/skills))  
* ❌ 使用已知存在重大安全事件的周邊工具版本（例如 Inspector auth bypass 類）而不做版本鎖與驗證。([Claude API Docs](https://docs.anthropic.com/en/docs/mcp))

**供應鏈/產物禁區**

* ❌ 產物不可追溯（無 provenance/attestation）；至少要能產出 SLSA 風格 provenance 或 GitHub attestation。([SLSA](https://slsa.dev/provenance))

  ### **3.5 衡量指標/驗收門檻（可量測，Fail-Closed）**

* **Lead time**：從任務→PR→required checks 全綠的平均時間（以 CI 時間戳統計）。  
* **人工介入率**：每次任務需要手動 approve 的次數（理想：只在 `bash/edit` 或 P2/敏感工具時觸發）。([opencode.ai](https://opencode.ai/docs/config))  
* **Gate 完整率**：Coverage Map 內 C0–C5 的 PASS 比例（主路徑要求 100%）。  
* **安全基線**：  
  * MCP 不暴露（0.0.0.0 檢測=0）。([backslash.security](https://www.backslash.security/blog/hundreds-of-mcp-servers-vulnerable-to-abuse))  
  * allowlist 覆蓋率=100%。  
  * 供應鏈證據（provenance/attestation）產出率=100%。([SLSA](https://slsa.dev/provenance))

  ---

  ## **4\) 風險與對策（偵測→緩解→備援）**

  ### **技術風險**

* **上下文污染/跨 CA 滲透**  
  * 偵測：isolation\_report 的輸入/輸出 hash 交叉比對。  
  * 緩解：每 CA workspace/memory 隔離；工作目錄強制分離。  
  * 備援：把該 CA 降級為手動模式（仍產證據）。  
* **MCP 供應鏈/工具鏈攻擊**  
  * 偵測：MCP server exposure 檢測、allowlist diff、掃描報告。([backslash.security](https://www.backslash.security/blog/hundreds-of-mcp-servers-vulnerable-to-abuse))  
  * 緩解：最小權限、sandbox、版本鎖、禁用未審核 skills。([Tom's Hardware](https://www.tomshardware.com/tech-industry/cyber-security/malicious-moltbot-skill-targets-crypto-users-on-clawhub))  
  * 備援：拔掉 MCP（OpenCode tools 全關），只保留靜態產物產出。([opencode.ai](https://opencode.ai/docs/config/))

  ### **資料風險**

* **秘密外洩（tokens/keys）**  
  * 偵測：secret scan（輸出進 evidence）。  
  * 緩解：禁把敏感值進 prompt/context；最小權限；必要時遮罩。  
  * 備援：rotate \+ revoke \+ 報告入 evidence。

  ### **法規/合規風險**

* **自動執行導向金融/高風險行為**  
  * 偵測：policy gate 掃到 execute path/外部副作用工具。  
  * 緩解：EXECUTE\_DISABLED \+ HITL/Kill-Switch。  
  * 備援：強制切斷寫入/網路工具（OpenCode tools 關閉）。([opencode.ai](https://opencode.ai/docs/config/))

  ### **營運風險**

* **輪子更新造成漂移（插件/skills 更新）**  
  * 偵測：lockfile \+ attestation/provenance \+ diff。([SLSA](https://slsa.dev/provenance))  
  * 緩解：版本釘死；更新走 PR；required checks。  
  * 備援：回退到上一個已簽章/已驗證版本。

  ---

  ## **5\) 來源索引（≥8；去重；含日期/站點）**

1. OpenCode Config（permissions/tools/mcp/plugins）— opencode.ai（2026-02，crawl 2 days）([opencode.ai](https://opencode.ai/docs/config/))（支撐：3.2/3.5）  
2. OpenCode Plugins — opencode.ai（2026-02，crawl 2 days）([opencode.ai](https://opencode.ai/docs/plugins/))（支撐：3.2）  
3. Oh My OpenCode（orchestration layer 定位）— ohmyopencode.com（2026-02-05）([ohmyopencode.com](https://ohmyopencode.com/))（支撐：2A/3.2）  
4. Anthropic Model Context Protocol repo — GitHub（2026，crawl 2 months）([GitHub](https://github.com/advisories/GHSA-7f8r-222p-6f5g))（支撐：3.2/4）  
5. Backslash：Hundreds of MCP servers vulnerable（NeighborJack 等）— backslash.security（2026-02，crawl 3 days）([backslash.security](https://www.backslash.security/blog/hundreds-of-mcp-servers-vulnerable-to-abuse))（支撐：2C/3.3/4）  
6. 研究：Mind Your Server / MCP-UPD / Parasitic Toolchain Attacks（arXiv 2509.06572）— aisecurity-portal \+ dblp（2025-09\~2025-10）([AIセキュリティポータル](https://aisecurity-portal.org/en/literature-database/mind-your-server-a-systematic-study-of-parasitic-toolchain-attacks-on-the-mcp-ecosystem/))（支撐：2C/4）  
7. MCP Inspector auth bypass（CVE-2025-49596 / GHSA）— GitHub Advisory Database（2026-02，crawl 2 months）([incibe.es](https://www.incibe.es/en/incibe-cert/early-warning/vulnerabilities/cve-2025-49596))（支撐：2C/3.4）  
8. Wiz：CVE-2025-49596（補充脈絡）— wiz.io（2026-02，crawl last month）([Claude API Docs](https://docs.anthropic.com/en/docs/mcp))（支撐：2C）  
9. OpenClaw Skills Docs（skills/供應鏈風險基礎）— docs.openclaw.ai（2026-02，crawl last month）([docs.openclaw.ai](https://docs.openclaw.ai/skills))（支撐：2C/3.4）  
10. Tom’s Hardware：惡意 skills/供應鏈風險報導 — tomshardware.com（2026-01，crawl last week）([Tom's Hardware](https://www.tomshardware.com/tech-industry/cyber-security/malicious-moltbot-skill-targets-crypto-users-on-clawhub))（支撐：2C/3.4）  
11. SLSA provenance（定義）— slsa.dev（2026-02，crawl 3 days）([SLSA](https://slsa.dev/provenance))（支撐：2D/4/3.4）  
12. slsa-framework/slsa-github-generator（GitHub Actions provenance 工具）— GitHub（2026-02，crawl 2 months）([GitHub](https://github.com/slsa-framework/slsa-github-generator))（支撐：2D/4）  
    ---

    ## **6\) 附錄（可選）**

    ### **你問的「兩方案誰優誰劣？」—可驗證裁決**

* **OpenClaw x Spartoi-OMOC升級建議**：更像“技巧庫/最佳實務清單”（隔離/分流/掃描），優點是提速、減錯；缺點是若沒收編進 Gate/Evidence，容易變成“流程裝飾”。  
* **本 v2 方案**：把技巧庫 **制度化**（每一技巧都有證據、有門檻、Fail-Closed），並把 OpenClaw 限制在 MCP allowlist sandbox 外圍層，優點是能通過 SRS/ARCH/ICD/RUNBOOK 的治理語境；缺點是你會多一點“護欄工程”，但那正是你要的低風險提速。  
  \=\> **更適合 Spartoi-OMOC 的是 v2**：因為 Spartoi 的“快”是建立在“可稽核的快”，不是“跑得快、死得更快”。  
  ---

END