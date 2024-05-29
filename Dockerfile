# Sử dụng image chính thức của Gradle với Java 21
FROM gradle:jdk-lts-and-current-graal-jammy AS builder

# Thiết lập thư mục làm việc
WORKDIR /home/gradle/project

# Sao chép file cấu hình và dependencies trước để cache
COPY build.gradle.kts settings.gradle.kts ./
COPY gradle ./gradle

# Tải dependencies
RUN gradle build -x test --no-daemon

# Sao chép toàn bộ source code
COPY . .

# Build ứng dụng
RUN gradle bootJar --no-daemon

# Sử dụng image JDK nhẹ để chạy ứng dụng
FROM openjdk:21-jdk-slim

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép file jar từ giai đoạn build trước
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

# Expose port
EXPOSE 8080

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
