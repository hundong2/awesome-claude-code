# 05단계: MCP - Model Context Protocol

## 이 단계에서 배울 것

MCP 서버를 추가해서 Claude의 능력을 외부 도구/서비스로 확장합니다.

---

## 5-1. MCP란?

MCP(Model Context Protocol)는 Claude가 외부 도구, 데이터베이스, API와 통신할 수 있게 해주는 표준 프로토콜입니다.

```
Claude ←→ MCP 프로토콜 ←→ MCP 서버 ←→ 외부 서비스
                                        (GitHub, Notion, DB 등)
```

---

## 5-2. 전송 방식 (Transport)

| 방식 | 설명 | 언제 사용 |
|------|------|-----------|
| `stdio` | 로컬 프로세스 실행 | 로컬 도구, CLI 래퍼 |
| `http` | HTTP 요청 (권장) | 원격 서비스, 클라우드 |
| `sse` | Server-Sent Events (deprecated) | 레거시 |

---

## 5-3. MCP 서버 관리 명령어

```bash
# 서버 목록 확인
claude mcp list

# 서버 추가 (stdio)
claude mcp add --transport stdio <이름> -- <실행명령어>

# 서버 추가 (HTTP)
claude mcp add --transport http <이름> <URL>

# 서버 상세 정보
claude mcp get <이름>

# 서버 제거
claude mcp remove <이름>

# Claude Desktop에서 가져오기
claude mcp add-from-claude-desktop
```

---

## 5-4. 스코프 (범위)

| 스코프 | 위치 | 공유 여부 |
|--------|------|-----------|
| `local` | `~/.claude.json` (현재 프로젝트) | 개인만 |
| `project` | `.mcp.json` (프로젝트 루트) | git으로 팀 공유 |
| `user` | `~/.claude.json` | 개인의 모든 프로젝트 |

```bash
# 스코프 지정 예시
claude mcp add --scope project <이름> <설정>
claude mcp add --scope user <이름> <설정>
```

---

## 5-5. 실용적인 MCP 서버 예시

### filesystem (파일 시스템 접근)

```bash
claude mcp add --transport stdio filesystem \
  -- npx -y @modelcontextprotocol/server-filesystem /tmp
```

### memory (영구 메모리)

```bash
claude mcp add --transport stdio memory \
  -- npx -y @modelcontextprotocol/server-memory
```

### fetch (웹 페이지 가져오기)

```bash
claude mcp add --transport stdio fetch \
  -- npx -y @modelcontextprotocol/server-fetch
```

### github (GitHub 통합)

```bash
claude mcp add --transport http github \
  --header "Authorization: Bearer YOUR_GITHUB_TOKEN" \
  https://api.githubcopilot.com/mcp/
```

---

## 5-6. .mcp.json 프로젝트 설정

팀과 공유하는 MCP 서버는 `.mcp.json`에 설정합니다.

```json
{
  "mcpServers": {
    "filesystem": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "./"],
      "env": {}
    },
    "fetch": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
```

---

## 5-7. MCP 도구 사용하기

MCP 서버 추가 후 인터랙티브 모드에서:

```
# MCP 서버 관리
/mcp

# MCP 도구는 자동으로 목록에 나타남
# 예: filesystem 서버 추가 시 파일 읽기/쓰기 도구 사용 가능

# MCP 프롬프트 실행
/mcp__서버이름__프롬프트이름

# MCP 리소스 참조
@서버이름:protocol://resource/path
```

---

## 5-8. 환경 변수로 인증

```bash
# API 키를 환경 변수로 전달
claude mcp add --transport stdio notion \
  --env NOTION_TOKEN=secret_xxxxx \
  -- npx -y @notionhq/notion-mcp-server
```

---

## 도구 검색 (Tool Search)

MCP 서버가 많을 때 자동으로 관련 도구 검색:

```bash
# 자동 활성화 (도구가 컨텍스트의 10% 초과 시)
ENABLE_TOOL_SEARCH=auto claude

# 항상 활성화
ENABLE_TOOL_SEARCH=true claude

# 비활성화
ENABLE_TOOL_SEARCH=false claude
```

---

## 다음 단계

MISSION.md 완료 후 `06-agents/`로 이동하세요.
