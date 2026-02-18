# Claude Code 핵심 치트시트

> 자주 찾아볼 명령어 모음

---

## CLI 플래그

```bash
claude                          # 인터랙티브 REPL
claude "질문"                   # 질문으로 REPL 시작
claude -p "질문"                # 단발성 질문 후 종료
claude -c                       # 최근 세션 이어하기
claude -r                       # 세션 목록에서 선택
claude -r "세션이름"            # 특정 세션 이어하기

claude --model claude-opus-4-6  # 모델 지정
claude --verbose -p "질문"      # 상세 출력 (사고 과정)
claude --permission-mode plan   # 읽기 전용 계획 모드
claude --permission-mode acceptEdits  # 편집 자동 승인

claude -p "질문" --output-format json  # JSON 출력
echo "내용" | claude -p "분석해줘"     # 파이프 입력
claude -p "질문" > output.md           # 파일로 저장
```

---

## 슬래시 명령어

```
/help       도움말
/status     버전/모델/계정 정보
/cost       토큰 사용량/비용
/usage      플랜 한도

/clear      대화 기록 초기화
/compact    대화 압축 (컨텍스트 절약)
/context    컨텍스트 사용량 시각화
/exit       세션 종료

/rename 이름   세션 이름 지정
/resume     세션 목록에서 이어하기
/export     대화 파일로 저장
/copy       마지막 응답 클립보드 복사

/model      모델 변경
/config     설정 UI
/permissions 권한 규칙 관리
/memory     CLAUDE.md 편집

/plan       플랜 모드 진입
/hooks      훅 관리
/agents     에이전트 관리
/mcp        MCP 서버 관리
```

---

## 단축키

```
Ctrl+C          취소
Ctrl+D          종료
Ctrl+L          화면 지우기 (기록 유지)
Ctrl+R          이전 명령어 검색
Shift+Tab       권한 모드 순환
Option+T        Extended Thinking 토글 (Mac)
Esc+Esc         마지막 응답 되감기

Ctrl+K          줄 끝까지 삭제
Ctrl+U          줄 전체 삭제
Alt+B           단어 단위 뒤로
Alt+F           단어 단위 앞으로
```

---

## MCP

```bash
claude mcp list                 # 서버 목록
claude mcp add --transport stdio <이름> -- <명령>   # stdio 추가
claude mcp add --transport http <이름> <URL>         # HTTP 추가
claude mcp remove <이름>        # 서버 제거
claude mcp get <이름>           # 서버 정보

# 자주 쓰는 MCP 서버
claude mcp add --transport stdio fetch -- npx -y @modelcontextprotocol/server-fetch
claude mcp add --transport stdio memory -- npx -y @modelcontextprotocol/server-memory
```

---

## 파일 구조

```
~/.claude/
├── settings.json       전역 설정
├── CLAUDE.md           전역 메모리 (모든 프로젝트)
├── agents/             전역 커스텀 에이전트
└── projects/
    └── [project]/
        └── memory/
            └── MEMORY.md  자동 메모리

[프로젝트]/
├── .claude/
│   ├── settings.json   프로젝트 설정
│   ├── CLAUDE.md       프로젝트 메모리 (팀 공유)
│   ├── agents/         프로젝트 커스텀 에이전트
│   └── rules/          경로별 규칙
├── .mcp.json           MCP 서버 (팀 공유)
└── CLAUDE.local.md     프로젝트 개인 메모리
```

---

## 권한 규칙

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(git status)",
      "Read"
    ],
    "ask": [
      "Bash(git push *)"
    ],
    "deny": [
      "Read(./.env)",
      "Bash(rm -rf *)"
    ],
    "defaultMode": "acceptEdits"
  }
}
```

---

## 커스텀 에이전트

```markdown
---
name: agent-name
description: 언제 이 에이전트를 사용하는지 설명
tools: Read, Grep, Glob
disallowedTools: Edit, Write
model: haiku
permissionMode: default
maxTurns: 10
---

에이전트 시스템 프롬프트...
```

---

## 훅 기본 구조

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "command": "bash /path/to/script.sh"
      }]
    }],
    "Stop": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "osascript -e 'display notification \"완료!\"'"
      }]
    }]
  }
}
```

---

## 모델 비교

| 모델 | 속도 | 비용 | 용도 |
|------|------|------|------|
| Haiku | 빠름 | 저렴 | 탐색, 요약, 간단한 작업 |
| Sonnet | 보통 | 중간 | 일반 코딩, 대부분 작업 |
| Opus | 느림 | 비쌈 | 복잡한 설계, 어려운 디버깅 |

---

## 환경 변수

```bash
ANTHROPIC_API_KEY=...              # API 키
CLAUDE_CODE_EFFORT_LEVEL=high      # 사고 노력 (low/medium/high)
CLAUDE_CODE_DISABLE_AUTO_MEMORY=1  # 자동 메모리 비활성화
ENABLE_TOOL_SEARCH=auto            # MCP 도구 검색 (auto/true/false)
MAX_THINKING_TOKENS=10000          # 최대 사고 토큰
```
