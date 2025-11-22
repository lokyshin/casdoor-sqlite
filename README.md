# Casdoor-SQLite | 单容器 IAM/SSO 方案

[![Docker Pulls](https://img.shields.io/docker/pulls/lokyshin/casdoor-sqlite)](https://hub.docker.com/r/lokyshin/casdoor-sqlite)
[![Docker Image Version](https://img.shields.io/docker/v/lokyshin/casdoor-sqlite?sort=semver)](https://hub.docker.com/r/lokyshin/casdoor-sqlite)
[![License](https://img.shields.io/github/license/lokyshin/casdoor-sqlite)](LICENSE)

[English :uk:](#english) | [中文 :cn:](#chinese)

---
## <span id="chinese">🇨🇳 中文介绍</span>

### 单容器、零依赖、开箱即用的 Casdoor IAM/SSO 平台（SQLite 版）

这是一款专为解决 MySQL 兼容性问题而优化的 Casdoor 镜像，通过静态编译 SQLite 驱动，实现真正的嵌入式数据库部署。

---

#### 核心特性

- ✅ **原生 SQLite 支持**：Go build tags 深度集成，无需外部数据库
- ✅ **单镜像部署**：前端、后端、数据库驱动三合一
- ✅ **数据持久化**：自动保存 `/data/casdoor.db`
- ✅ **版本锁定**：所有组件版本固定，构建结果可复现
- ✅ **开箱即用**：默认账号密码，一键启动

---

#### 为什么需要 SQLite 版本？

**Casdoor 官方默认不支持 SQLite**，且使用 MySQL 时常遇到：

- **SQL 拼接错误**：特定场景下 SQL 语句语法兼容性问题
- **外键约束异常**：MySQL 外键处理与 ORM 预期不一致
- **运维复杂度高**：需额外维护数据库服务，增加部署难度

本项目通过 `-tags "sqlite"` 编译参数，将 SQLite 驱动静态链接到二进制中，提供**零依赖、零配置**的嵌入式数据库方案，彻底解决 MySQL 兼容性问题。

---

#### 版本信息（已锁定）

| 组件 | 版本 | 来源 |
|------|------|------|
| **Casdoor** | v2.156.0 | Git 提交 `d8b5ecba36de` |
| **SQLite 驱动** | v1.18.2 | go.mod (`modernc.org/sqlite`) |
| **SQLite 引擎** | 3.38.5 | 驱动内置版本 |
| **Go 编译器** | 1.23 | 静态编译 |
| **Node.js** | 18 | 前端构建环境 |

---

#### 快速开始

```bash
# 创建数据目录
mkdir -p sqlite_data

# 启动容器
docker run -d --name casdoor-sqlite \
  -p 12880:8000 \
  -e driverName=sqlite \
  -e dataSourceName=/data/casdoor.db \
  -v "$PWD/sqlite_data":/data \
  --restart always \
  lokyshin/casdoor-sqlite:1.0.5

# 访问
# http://localhost:12880
# 账号: admin 密码: 123
```
---

#### 环境变量

| 变量名 | 值 | 说明 |
|--------|----|------|
| `driverName` | `sqlite` | 必须指定 SQLite 驱动 |
| `dataSourceName` | `/data/casdoor.db` | 数据库文件路径（建议挂载卷） |

#### 数据持久化

- **卷挂载路径**：`/data`
- **数据库文件**：`/data/casdoor.db`
- **备份建议**：定期备份 `sqlite_data/` 目录

#### 默认账号

- **用户名**：`admin`
- **密码**：`123`
- **首次登录后**：请立即修改默认密码

#### 源码 & 构建

```bash
# 从源码构建
git clone https://github.com/casdoor/casdoor
cd casdoor
docker build -f Dockerfile.sqlite -t casdoor-sqlite .
```

#### 许可证
Apache License 2.0

---
<span id="english">
## 🇺🇸 English Description

### Single-container, Zero-dependency, Ready-to-use Casdoor IAM/SSO Platform (SQLite Edition)

This image is optimized to solve MySQL compatibility issues by statically compiling SQLite driver for true embedded database deployment.

---

#### Key Features

- ✅ **Native SQLite Support**: Deeply integrated via Go build tags, no external database required
- ✅ **Single Container**: Frontend, backend, and database driver all-in-one
- ✅ **Data Persistence**: Auto-saves `/data/casdoor.db`
- ✅ **Version Locking**: All components pinned for reproducible builds
- ✅ **Out-of-the-box**: Default credentials, one-click start

---

#### Why SQLite Edition?

**Casdoor doesn't support SQLite by default**, and MySQL users often face:

- **SQL Concatenation Errors**: Syntax compatibility issues in specific scenarios
- **Foreign Key Anomalies**: MySQL's FK handling inconsistent with ORM expectations
- **High Ops Complexity**: Requires separate database maintenance

This project uses `-tags "sqlite"` to statically link SQLite driver, providing a **zero-dependency, zero-config** embedded database solution that completely resolves MySQL compatibility issues.

---

#### Version Information (Locked)

| Component | Version | Source |
|-----------|---------|--------|
| **Casdoor** | v2.156.0 | Git commit `d8b5ecba36de` |
| **SQLite Driver** | v1.18.2 | go.mod (`modernc.org/sqlite`) |
| **SQLite Engine** | 3.38.5 | Built into driver |
| **Go Compiler** | 1.23 | Statically compiled |
| **Node.js** | 18 | Frontend build env |

---

#### Quick Start

```bash
# Create data directory
mkdir -p sqlite_data

# Run container
docker run -d --name casdoor-sqlite \
  -p 12880:8000 \
  -e driverName=sqlite \
  -e dataSourceName=/data/casdoor.db \
  -v "$PWD/sqlite_data":/data \
  --restart always \
  lokyshin/casdoor-sqlite:1.0.5

# Access
# http://localhost:12880
# Username: admin Password: 123
```

---

#### Environment Variables

| Variable | Value | Description |
|----------|-------|-------------|
| `driverName` | `sqlite` | Must specify SQLite driver |
| `dataSourceName` | `/data/casdoor.db` | DB file path (recommend volume mount) |

#### Data Persistence

- **Volume mount**: `/data`
- **Database file**: `/data/casdoor.db`
- **Backup**: Regularly backup `sqlite_data/` directory

#### Default Credentials

- **Username**: `admin`
- **Password**: `123`
- **Security**: Please change default password after first login

#### Source & Build

```bash
# Build from source
git clone https://github.com/casdoor/casdoor
cd casdoor
docker build -f Dockerfile.sqlite -t casdoor-sqlite .
```

---

#### License
Apache License 2.0
