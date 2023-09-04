# ビルドステージ
FROM openjdk:17-jdk-slim AS build
WORKDIR /workspace
# 依存関係の解決とビルドを行うためのファイルをコピー
COPY gradlew .
COPY gradle gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY src src
# ビルド実行
RUN ./gradlew build

# 使用するベースイメージ
FROM openjdk:17-jdk-slim

# 作業ディレクトリを設定
WORKDIR /app

# アプリケーションのJARをコピー
COPY build/libs/circleConnect-0.0.1-SNAPSHOT.jar /app/circleConnect.jar

# ポート8080を開放
EXPOSE 8080

# コンテナ起動時のコマンド
CMD ["java", "-jar", "/app/circleConnect.jar"]
