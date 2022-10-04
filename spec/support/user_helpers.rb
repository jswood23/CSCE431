module UserHelpers
  # globals
  @@admin_email = "admin@email.com"
  @@admin_password = "adminpw23"
  @@member_email = "member@email.com"
  @@member_password = "memberpw23"

  def log_out
    click_link("Logout")
    expect(page).to have_content("Signed out successfully.")
  end

  def create_accounts
    # admin account
    visit "/users/sign_up"
    within "#new_user" do
      fill_in "user_email", :with => @@admin_email
      fill_in "user_password", :with => @@admin_password
      fill_in "user_password_confirmation", :with => @@admin_password
      click_button("Sign up")
    end
    expect(page).to have_content("User has been made an admin because there were no existing admins.")
    log_out()

    # member account
    visit "/users/sign_up"
    within "#new_user" do
      fill_in "user_email", :with => @@member_email
      fill_in "user_password", :with => @@member_password
      fill_in "user_password_confirmation", :with => @@member_password
      click_button("Sign up")
    end
    expect(page).to have_content("Welcome! You have signed up successfully.")
    log_out()
  end

  def log_in_admin
    visit "/users/sign_in"
    within "#new_user" do
      fill_in "user_email", :with => @@admin_email
      fill_in "user_password", :with => @@admin_password
      click_button("Log in")
    end
    expect(page).to have_content("Signed in successfully.")
  end

  def log_in_member(is_member = true)
    # give false as a parameter if this user should have no permissions
    visit "/users/sign_in"
    within "#new_user" do
      fill_in "user_email", :with => @@member_email
      fill_in "user_password", :with => @@member_password
      click_button("Log in")
    end
    expect(page).to have_content("Signed in successfully.")

    # change user permissions between user and member if necessary
    this_user = User.where(email: @@member_email).first
    if is_member
      if !this_user.member
        this_user.member = true
        this_user.save()
      end
    else
      if this_user.member
        this_user.member = true
        this_user.save()
      end
    end
  end
end