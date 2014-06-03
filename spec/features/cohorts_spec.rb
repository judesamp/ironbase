require 'spec_helper'
include AuthenticationHelper


feature "add a cohort instructor" do 
  let(:user) { FactoryGirl.create(:user) }
  let(:location) { FactoryGirl.create(:location) }
  let(:course) { FactoryGirl.create(:course) }
  let(:second_user) { FactoryGirl.create(:second_user) }
  let(:cohort) {FactoryGirl.create(:cohort)}


  scenario "user who isn't logged in should fail attempting to reach location page" do
    visit '/locations/1'
    current_path.should eq("/users/sign_in")
  end

  scenario "logged-in, regular user should fail attempting to reach location page" do
    login(user)
    visit '/locations/1'
    current_path.should eq("/")
  end

  scenario "logged-in, admin user should reach location page" do
    login(user)
    user.add_role :admin
    visit location_path(location.id)
    current_path.should eq location_path(location.id)
  end

  scenario "add instructor to cohort on cohort creation" do
    second_user.add_role :admin
    puts course.inspect
    login(user)
    user.add_role :admin
    visit location_path(location.id)
    find('.create_cohort_button').click
    fill_in('cohort[start_date]', :with => Date.today)
    fill_in('cohort[end_date]', :with => Date.today + 1)
    select('email@email.com', :from => 'cohort[instructor_id]')
    select('Ruby on Rails', :from => 'cohort[course_id]')
    select('Atlanta', :from => 'cohort[location_id]')
    click_button 'Create Cohort'
    current_path.should eq location_path(location.id)
  end

  scenario "leave instructor blank on cohort creation" do
    second_user.add_role :admin
    puts course.inspect
    login(user)
    user.add_role :admin
    visit location_path(location.id)
    find('.create_cohort_button').click
    fill_in('cohort[start_date]', :with => Date.today)
    fill_in('cohort[end_date]', :with => Date.today + 1)
    select('email@email.com', :from => 'cohort[instructor_id]')
    select('Atlanta', :from => 'cohort[location_id]')
    click_button 'Create Cohort'
    current_path.should eq location_path(location.id)
  end

end


feature "add a cohort instructor" do 
  let(:user) { FactoryGirl.create(:user) }
  let(:location) { FactoryGirl.create(:location) }
  let(:cohort) { FactoryGirl.create(:cohort) }
  let(:second_user) { FactoryGirl.create(:second_user) }

  scenario "add instructor to cohort" do
    cohort = FactoryGirl.create(:cohort)
    user.add_role :admin
    second_user.add_role :admin
    login(user)
    visit location_path(cohort.location_id)
    save_and_open_page
    find('#add').click
    select('email@email.com', :from => 'add_class')
    click_button 'Add Instructor'
    current_path.should eq location_path(cohort.location_id)
  end

end

feature "remove a cohort instructor" do 
  let(:user) { FactoryGirl.create(:user) }
  let(:location) { FactoryGirl.create(:location) }
  let(:course) { FactoryGirl.create(:course) }
  let(:second_user) { FactoryGirl.create(:second_user) }
  let(:cohort) {FactoryGirl.create(:cohort)}

  scenario "remove instructor from cohort" do
    second_user.add_role :admin
    cohort.instructor_id = second_user.id
    cohort.save
    login(user)
    user.add_role :admin
    visit location_path(cohort.location_id)
    find('.remove_instructor_button').click
    click_button 'Click to Remove Instructor'
    current_path.should eq location_path(cohort.location_id)
  end

end

feature "authorization of cohort dashboard" do
  let(:user) { FactoryGirl.create(:user) }

  scenario "user who isn't logged in should fail attempting to reach cohort dashboard" do
    visit '/cohorts/1'
    current_path.should eq("/users/sign_in")
  end

  scenario "logged-in, regular user should fail attempting to reach cohort dashboard" do
    login(user)
    visit '/locations/1'
    current_path.should eq("/")
  end

  scenario "logged-in, admin user should reach cohort dashboard" do
    cohort = FactoryGirl.create(:cohort)
    login(user)
    user.add_role :admin
    visit cohort_path(cohort.id)
    current_path.should eq cohort_path(cohort.id)
  end

end




