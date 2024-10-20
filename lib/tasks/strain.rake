# frozen_string_literal: true

namespace :strain do
  desc 'Get sensors value'
  task seed: :environment do
    require 'csv'

    # parse strains
    strains_csv = Rails.root.join('db', 'samples', 'strains-kushy_api.2017-11-14.csv')
    CSV.parse(File.new(strains_csv), col_sep: ',', headers: false) do |row|
      Strain.create!(
        name: row[3] && (row[3] != 'NULL') ? row[3] : nil,
        description: row[6] && (row[6] != 'NULL') ? row[6] : nil,
        strain_type: row[7] && (row[7] != 'type') ? row[7].downcase.to_sym : nil,
        crosses: row[8] && (row[8] != 'NULL') ? row[8] : nil,
        breeder: row[9] && (row[9] != 'NULL') ? row[9] : nil,
        effects: if row[10] && (row[10] != 'NULL')
                   row[10].split(',').map do |e|
                     e.downcase.strip
                   end
                 end,
        ailments: if row[11] && (row[11] != 'NULL')
                    row[11].split(',').map do |e|
                      e.downcase.strip
                    end
                  end,
        flavors: if row[12] && (row[12] != 'NULL')
                   row[12].split(',').map do |e|
                     e.downcase.strip
                   end
                 end,
        location: row[13] && (row[13] != 'NULL') ? row[13] : nil,
        terpenes: row[14] && (row[14] != 'NULL') ? row[14] : nil
      )
    end

    Strain.first.destroy
  end
end
