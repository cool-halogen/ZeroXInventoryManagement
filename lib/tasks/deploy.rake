namespace :deploy do
  desc 'Sort data by mine site, create SQLite databases, and simulate deployment'
  task sort_and_deploy: :environment do
    require 'sqlite3'
    require 'fileutils'

    # Sample data structure
    data = [
      { "mine_site" => "A", "data" => [
          { "id" => 1, "name" => "Ore A", "value" => "High" },
          { "id" => 2, "name" => "Ore B", "value" => "Medium" }
        ]
      },
      { "mine_site" => "B", "data" => [
          { "id" => 3, "name" => "Ore C", "value" => "Low" },
          { "id" => 4, "name" => "Ore D", "value" => "High" }
        ]
      }
    ]

    # Function to create SQLite database for each mine site
    def create_database(mine)
      mine_site = mine["mine_site"]
      FileUtils.mkdir_p("databases/#{mine_site}")

      db = SQLite3::Database.new("databases/#{mine_site}/data.db")
      db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS data (
          id INTEGER PRIMARY KEY,
          name TEXT,
          value TEXT
        );
      SQL

      mine["data"].each do |row|
        db.execute("INSERT INTO data (id, name, value) VALUES (?, ?, ?)", row["id"], row["name"], row["value"])
      end

      db.close
    end

    # Function to simulate deployment by copying databases
    def deploy_to_region(region, mine_sites)
      FileUtils.mkdir_p("deployments/#{region}")
      mine_sites.each do |mine_site|
        FileUtils.cp_r("databases/#{mine_site}", "deployments/#{region}/")
      end
    end

    # Create databases for each mine site
    data.each do |mine|
      create_database(mine)
    end

    # Simulate deployment to regions
    regions = ['China', 'Germany', 'Wakanda']
    mine_sites = data.map { |mine| mine["mine_site"] }

    regions.each do |region|
      deploy_to_region(region, mine_sites)
    end

    puts "Deployment completed successfully."
  end
end
