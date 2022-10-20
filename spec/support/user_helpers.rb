# frozen_string_literal: true

# rubocop:disable Style/ClassVars

module UserHelpers
  # admin constants
  @@admin_name = 'Administrator'
  @@admin_email = 'admin@email.com'
  @@admin_password = 'adminpw23'

  # member constants
  @@member_name = 'Average Joe'
  @@member_email = 'member@email.com'
  @@member_password = 'memberpw23'

  # alumni constants
  @@alumni_name = 'Alumni'
  @@alumni_email = 'alumni@email.com'
  @@alumni_password = 'alumnipw23'

  def log_out
    click_link('Logout')
    expect(page).to(have_content('Signed out successfully.'))
  end

  def create_accounts
    # create admin account
    visit('/users/sign_up')
    within('#new_user') do
      fill_in('user_full_name', with: @@admin_name)
      fill_in('user_email', with: @@admin_email)
      fill_in('user_password', with: @@admin_password)
      fill_in('user_password_confirmation', with: @@admin_password)
      click_button('Sign up')
    end
    expect(page).to(have_content("User #{@@admin_name} has been made an admin because there were no existing admins."))
    log_out

    # create member account
    visit('/users/sign_up')
    within('#new_user') do
      fill_in('user_full_name', with: @@member_name)
      fill_in('user_email', with: @@member_email)
      fill_in('user_password', with: @@member_password)
      fill_in('user_password_confirmation', with: @@member_password)
      click_button('Sign up')
    end
    expect(page).to(have_content('Welcome! You have signed up successfully.'))
    log_out

    # create alumni account
    visit('/users/sign_up')
    within('#new_user') do
      fill_in('user_full_name', with: @@alumni_name)
      fill_in('user_email', with: @@alumni_email)
      fill_in('user_password', with: @@alumni_password)
      fill_in('user_password_confirmation', with: @@alumni_password)
      click_button('Sign up')
    end
    expect(page).to(have_content('Welcome! You have signed up successfully.'))
    log_out
  end

  def log_in_admin
    visit('/users/sign_in')
    within('#new_user') do
      fill_in('user_email', with: @@admin_email)
      fill_in('user_password', with: @@admin_password)
      click_button('Log in')
    end
    expect(page).to(have_content('Signed in successfully.'))
  end

  def log_in_member(member: true)
    # give false as a parameter if this user should have no permissions
    visit('/users/sign_in')
    within('#new_user') do
      fill_in('user_email', with: @@member_email)
      fill_in('user_password', with: @@member_password)
      click_button('Log in')
    end
    expect(page).to(have_content('Signed in successfully.'))

    # change user permissions between user and member if necessary
    this_user = User.where(email: @@member_email).first
    if member
      unless this_user.member
        this_user.member = true
        this_user.save!
      end
    elsif this_user.member
      this_user.member = true
      this_user.save!
    end
  end

  def log_in_alumni(alumni: true)
    # give false as a parameter if this user should have no permissions
    visit('/users/sign_in')
    within('#new_user') do
      fill_in('user_email', with: @@alumni_email)
      fill_in('user_password', with: @@alumni_password)
      click_button('Log in')
    end
    expect(page).to(have_content('Signed in successfully.'))

    # change user permissions between user and member if necessary
    this_user = User.where(email: @@alumni_email).first
    if alumni
      unless this_user.alumni
        this_user.alumni = true
        this_user.member = true
        this_user.save!
      end
    elsif this_user.alumni
      this_user.alumni = true
      this_user.member = true
      this_user.save!
    end
  end
end

# rubocop:enable Style/ClassVars
