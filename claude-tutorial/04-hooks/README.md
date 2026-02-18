# 04단계: 훅(Hooks) - 이벤트 기반 자동화

## 이 단계에서 배울 것

Claude Code의 훅 시스템으로 도구 실행 전/후에 자동화 작업을 설정합니다.

---

## 4-1. 훅이란?

훅은 **Claude의 특정 이벤트에 반응해서 자동으로 실행되는 명령어**입니다.

```
사용자가 메시지 전송
    ↓
UserPromptSubmit 훅 실행
    ↓
Claude가 도구 사용 결정
    ↓
PreToolUse 훅 실행 → (차단 가능)
    ↓
도구 실행
    ↓
PostToolUse 훅 실행
    ↓
Claude가 응답 완료
    ↓
Stop 훅 실행 (알림 등)
```

---

## 4-2. 훅 이벤트 종류

| 이벤트 | 발생 시점 | 차단 가능? |
|--------|-----------|------------|
| `SessionStart` | 세션 시작 시 | 아니오 |
| `UserPromptSubmit` | 프롬프트 제출 시 | 예 |
| `PreToolUse` | 도구 실행 직전 | 예 |
| `PostToolUse` | 도구 실행 성공 후 | 아니오 |
| `PostToolUseFailure` | 도구 실행 실패 후 | 아니오 |
| `Notification` | Claude가 알림 보낼 때 | 아니오 |
| `Stop` | Claude 응답 완료 시 | 아니오 |
| `PreCompact` | 컨텍스트 압축 전 | 아니오 |
| `SessionEnd` | 세션 종료 시 | 아니오 |

---

## 4-3. 훅 설정 방법

`~/.claude/settings.json` 또는 `.claude/settings.json`에 설정:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo '🛑 Bash 실행: ' && cat"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"Claude 완료!\" with title \"Claude Code\"'"
          }
        ]
      }
    ]
  }
}
```

---

## 4-4. PreToolUse - 위험한 명령어 차단

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'read INPUT; if echo \"$INPUT\" | grep -qE \"rm -rf|DROP TABLE|format\"; then echo \"위험한 명령어 차단됨\" >&2; exit 2; fi; echo \"$INPUT\"'"
          }
        ]
      }
    ]
  }
}
```

**종료 코드의 의미**:
- `0`: 허용 (계속 진행)
- `2`: 차단 (stderr 메시지를 Claude에게 전달)
- 기타: 허용하되 stderr는 로그에만

---

## 4-5. PostToolUse - 자동 포맷팅

파일 편집 후 자동으로 포맷팅:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'read INPUT; FILE=$(echo \"$INPUT\" | jq -r \".tool_input.file_path // .tool_input.path // empty\"); if [[ \"$FILE\" == *.py ]]; then python3 -m black \"$FILE\" 2>/dev/null || true; fi'"
          }
        ]
      }
    ]
  }
}
```

---

## 4-6. Notification - macOS 알림

Claude가 완료되었을 때 알림 보내기:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"작업 완료!\" with title \"Claude Code\" sound name \"Glass\"'"
          }
        ]
      }
    ]
  }
}
```

---

## 4-7. 훅 타입: command vs prompt vs agent

```json
// 1. command: 쉘 명령어 실행 (가장 빠름)
{
  "type": "command",
  "command": "echo 'hello'"
}

// 2. prompt: Claude에게 평가 요청 (AI 판단)
{
  "type": "prompt",
  "prompt": "이 코드 변경이 보안에 문제가 없는지 확인해줘"
}

// 3. agent: 도구를 가진 Claude 에이전트 실행
{
  "type": "agent",
  "prompt": "변경된 파일의 테스트를 실행하고 결과 보고해줘"
}
```

---

## 4-8. /hooks 명령어

```
# 인터랙티브 모드에서
/hooks  → 훅 관리 UI 열기
```

---

## 훅 디버깅 팁

```bash
# 훅 실행 로그 확인
claude --debug hooks -p "테스트"

# 훅이 받는 JSON 입력 확인 (PreToolUse)
# settings.json에 임시 추가:
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "command": "tee /tmp/hook-debug.json"
      }]
    }]
  }
}
# 실행 후: cat /tmp/hook-debug.json
```

---

## 다음 단계

MISSION.md 완료 후 `05-mcp/`로 이동하세요.
