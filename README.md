# project_context

**One capability bit from GBT V8, packaged standalone.** No. 192 of 341,
`project` domain (Project).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 项目上下文：**文档面**（blueprint 蓝图 / brief 简报 / search 只读检索 / status）＋ **代码结构四面**（2026-09-23 接，补上「专业级编程AI」缺的那半身）：`symbols` 符号（顶层 def/class，可按名问「在哪定义」）· `deps` 依赖（内部 import 边 + 外部三方名）· `calls` 调用图（**复用现成 `tools/call_graph.py`**：find/callers/callees/trace/dead_code，4.2s / 351 文件）· `tests` 测试面（模块被哪些测试**提到**过）· `structure` 三面速览（4.4s，**刻意不含调用图**）。全部只读。⚠️ 四处诚实边界随结果一起带出：符号只收**顶层**；依赖只看 **import 语句**；调用图带**未解析率**（本仓约 0.66，所以「没人调用」先天有缺口）；测试面是**提到过**的代理**不是行覆盖**。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-project-context.git
cd gbt-project-context
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_project_context info                  # capability card
python -m gbt_project_context spec --json           # machine-readable contract
python -m gbt_project_context check --payload '{}'
python -m gbt_project_context run   --payload '{}'
```

Real `info` output from this machine:

```text
project_context  (project)  v1.0.0
----------------------------------------
项目上下文：**文档面**（blueprint 蓝图 / brief 简报 / search 只读检索 / status）＋ **代码结构四面**（2026-09-23 接，补上「专业级编程AI」缺的那半身）：`symbols` 符号（顶层 def/class，可按名问「在哪定义」）· `deps` 依赖（内部 import 边 + 外部三方名）· `calls` 调用图（**复用现成 `tools/call_graph.py`**：find/callers/callees/trace/dead_code，4.2s / 351 文件）· `tests` 测试面（模块被哪些测试**提到**过）· `structure` 三面速览（4.4s，**刻意不含调用图**）。全部只读。⚠️ 四处诚实边界随结果一起带出：符号只收**顶层**；依赖只看 **import 语句**；调用图带**未解析率**（本仓约 0.66，所以「没人调用」先天有缺口）；测试面是**提到过**的代理**不是行覆盖**。

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : find, callers, callees, trace, dead_code
```

Wire a real implementation:

```python
from gbt_project_context import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（5 个）**：`find`、`callers`、`callees`、`trace`、`dead_code`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.13s
```

## Provenance

| field | value |
|---|---|
| capability | `project_context` |
| domain | `project` |
| handler | `project_context` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [project/project_context](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/project/project_context.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
