# Claude Code 전문가 되기 - 단계별 학습 가이드

> Claude Code 공식 문서 기반으로 제작된 한국어 실습 튜토리얼

---

## 학습 진도 추적

| 단계 | 주제 | 상태 |
|------|------|------|
| [01](./01-basics/) | 기초 - CLI 명령어 및 기본 사용법 | ⬜ 미시작 |
| [02](./02-interactive/) | 인터랙티브 모드 - 슬래시 명령어 & 단축키 | ⬜ 미시작 |
| [03](./03-config/) | 설정 - CLAUDE.md & settings.json | ⬜ 미시작 |
| [04](./04-hooks/) | 훅(Hooks) - 자동화 & 워크플로우 | ⬜ 미시작 |
| [05](./05-mcp/) | MCP - Model Context Protocol | ⬜ 미시작 |
| [06](./06-agents/) | 에이전트 - 서브에이전트 & 팀 | ⬜ 미시작 |
| [07](./07-advanced/) | 고급 기능 - 메모리, Extended Thinking 등 | ⬜ 미시작 |
| [08](./08-workflows/) | 실전 워크플로우 - CI/CD, 자동화 | ⬜ 미시작 |

상태: ⬜ 미시작 | 🔄 진행중 | ✅ 완료

---

## 학습 방법

1. **각 단계 폴더**의 `README.md`를 먼저 읽는다
2. **실습 명령어**를 직접 터미널에서 실행해본다
3. **PRACTICE.md**에 본인이 시도한 것과 결과를 기록한다
4. 완료 후 위 표의 상태를 ✅로 업데이트한다

---

## 빠른 참조 (Quick Reference)

| 자주 쓰는 명령 | 설명 |
|--------------|------|
| `claude` | 인터랙티브 REPL 시작 |
| `claude -p "질문"` | 단발성 질문 후 종료 |
| `claude -c` | 마지막 세션 이어하기 |
| `/clear` | 대화 기록 초기화 |
| `/help` | 도움말 |
| `/status` | 버전/모델/계정 정보 |
| `/cost` | 토큰 사용량 확인 |
| `/compact` | 컨텍스트 압축 |
| `Shift+Tab` | 권한 모드 전환 |
| `Ctrl+C` | 현재 작업 취소 |

---

## 폴더 구조

```
claude-tutorial/
├── README.md              ← 지금 이 파일 (인덱스)
├── PROGRESS.md            ← 학습 기록 일지
├── CHEATSHEET.md          ← 핵심 명령어 치트시트
├── 01-basics/             ← CLI 기초
├── 02-interactive/        ← 인터랙티브 모드
├── 03-config/             ← 설정 파일
├── 04-hooks/              ← 훅 자동화
├── 05-mcp/                ← MCP 서버
├── 06-agents/             ← 에이전트
├── 07-advanced/           ← 고급 기능
└── 08-workflows/          ← 실전 워크플로우
```

---

## 참고 링크

- [공식 문서](https://docs.anthropic.com/en/docs/claude-code)
- [GitHub](https://github.com/anthropics/claude-code)
- [릴리즈 노트](https://docs.anthropic.com/en/docs/claude-code/release-notes)
