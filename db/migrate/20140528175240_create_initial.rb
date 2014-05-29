class CreateInitial < ActiveRecord::Migration
  def change

    create_table :assignments do |t|
      t.string :name
      t.text :description
      t.string :email

      t.timestamps
    end

    create_table :cohorts do |t|
      t.string :name
      t.string :subject
      t.date :start_date
      t.date :end_date

      t.timestamps
    end

    create_table :courses do |t|
      t.string :name
      t.string :syllabus

      t.timestamps
    end

    create_table :submissions do |t|
      t.text :content 
      t.text :notes
      t.string :file_submissions

      t.timestamps
    end

    create_table :locations do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end

    create_table :links do |t|
      t.string :content
    end

  end

end
