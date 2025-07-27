# Use official dbt image
FROM ghcr.io/dbt-labs/dbt-postgres:1.8.2

# Set the working directory
WORKDIR /usr/app/dbt/

# Copy dbt project files
COPY . .

# Install dbt dependencies
RUN dbt deps

# Command to run dbt transformations
CMD ["build", "--profiles-dir", ".dbt"]