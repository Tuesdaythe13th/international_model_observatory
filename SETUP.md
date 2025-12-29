# Research Cabal MCP Setup Guide

This repository contains a **TrendRadar MCP Server** - a news aggregation and analysis tool that provides AI assistants with powerful capabilities to track, analyze, and understand news trends.

## What This MCP Server Does

The TrendRadar MCP server provides comprehensive tools for:

### Core Features
- **News Aggregation**: Fetch latest news from multiple platforms (Weibo, Douyin, Zhihu, Baidu, etc.)
- **Trend Analysis**: Track topic trends, lifecycle analysis, viral detection, and predictions
- **Sentiment Analysis**: Analyze news sentiment and emotional trends
- **Smart Search**: Keyword, fuzzy, and entity-based news search
- **Data Insights**: Platform comparisons, activity statistics, keyword co-occurrence

### Available Tools (13 total)
1. `resolve_date_range` - Parse natural language dates ("this week", "last 7 days")
2. `get_latest_news` - Get most recent crawled news
3. `get_news_by_date` - Query news by specific date
4. `get_trending_topics` - Get trending topic statistics
5. `search_news` - Unified search (keyword/fuzzy/entity)
6. `search_related_news_history` - Find related historical news
7. `analyze_topic_trend` - Topic trend analysis (heat/lifecycle/viral/predict)
8. `analyze_data_insights` - Data insights (platform compare/activity/keywords)
9. `analyze_sentiment` - Sentiment analysis
10. `find_similar_news` - Find similar news articles
11. `generate_summary_report` - Generate daily/weekly summaries
12. `get_current_config` - Get system configuration
13. `get_system_status` - Get system status
14. `trigger_crawl` - Manually trigger news crawling

## Installation & Setup

### Prerequisites
- Python 3.10 or higher
- pip (Python package manager)

### Step 1: Install Dependencies

```bash
pip install --ignore-installed PyYAML -r requirements.txt
```

### Step 2: Configure the Server

The configuration files are located in `config/`:
- `config.yaml` - Main configuration (platforms, crawling settings, notifications)
- `frequency_words.txt` - Keywords to monitor

You can customize these files to adjust:
- Which platforms to monitor
- Crawling intervals
- Notification settings
- Keywords of interest

### Step 3: Test the Server

Test that the server starts correctly:

```bash
# Test stdio mode (for Claude Desktop)
python3 -m mcp_server.server --transport stdio

# Test HTTP mode (for production)
python3 -m mcp_server.server --transport http --port 3333
```

Press `Ctrl+C` to stop the server.

## Using with Claude Desktop

To use this MCP server with Claude Desktop, add the following configuration to your Claude Desktop config file:

**macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "trendradar-research-cabal": {
      "command": "python3",
      "args": [
        "-m",
        "mcp_server.server",
        "--transport",
        "stdio",
        "--project-root",
        "/home/user/international_model_observatory"
      ],
      "env": {}
    }
  }
}
```

**Important**: Replace `/home/user/international_model_observatory` with the actual absolute path to this repository on your system.

After adding the configuration:
1. Restart Claude Desktop
2. The TrendRadar tools will be available in your conversations
3. You can ask Claude to search news, analyze trends, etc.

## Using with HTTP Mode

For production deployments or web-based integrations:

```bash
# Start server in HTTP mode
python3 -m mcp_server.server --transport http --host 0.0.0.0 --port 3333
```

The server will be available at `http://localhost:3333/mcp`

## Example Usage

Once configured, you can ask Claude:

- "Get the latest news from Weibo and Zhihu"
- "Analyze AI trends over the last week"
- "Search for news about Tesla from this month"
- "Show me sentiment analysis for climate change news"
- "Find news similar to [some title]"
- "Generate a daily summary report"

## Project Structure

```
international_model_observatory/
├── mcp_server/          # MCP server implementation
│   ├── server.py       # Main server entry point
│   ├── tools/          # Tool implementations
│   ├── services/       # Business logic services
│   └── utils/          # Utility functions
├── config/             # Configuration files
│   ├── config.yaml     # Main configuration
│   └── frequency_words.txt  # Keywords to monitor
├── main.py             # Standalone crawler (non-MCP mode)
├── requirements.txt    # Python dependencies
└── SETUP.md           # This file
```

## Troubleshooting

### Import Errors
If you get import errors, ensure all dependencies are installed:
```bash
pip install --ignore-installed PyYAML -r requirements.txt
```

### Connection Issues
The server may fail to connect to some news sources due to:
- Network restrictions
- Proxy settings (check `config/config.yaml`)
- API availability

### Path Issues
Make sure to use absolute paths in the Claude Desktop configuration.

## Development

To modify or extend the server:

1. **Add new tools**: Edit `mcp_server/server.py` and add decorated functions
2. **Add new platforms**: Update `config/config.yaml` with new platform definitions
3. **Customize analysis**: Modify files in `mcp_server/services/` and `mcp_server/tools/`

## License

See `LICENSE` file for details.

## Version

Current version: 1.0.3 (TrendRadar MCP Server)
