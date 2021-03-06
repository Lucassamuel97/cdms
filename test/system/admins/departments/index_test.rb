require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  context 'departments' do
    setup do
      admin = create(:admin)
      login_as(admin, scope: :admin)
    end

    should 'list all' do
      departments = create_list(:department, 3)
      visit admins_departments_path

      within('table.table tbody') do
        departments.each_with_index do |department, index|
          child = index + 1
          base_selector = "tr:nth-child(#{child})"

          assert_selector "#{base_selector} a[href='#{admins_department_path(department)}']",
                          text: department.initials
          assert_selector base_selector, text: department.name
          assert_selector base_selector, text: department.local
          assert_selector base_selector, text: department.phone
          assert_selector base_selector, text: department.email

          assert_selector "#{base_selector} a[href='#{edit_admins_department_path(department)}']"
          assert_selector "#{base_selector} a[href='#{admins_department_path(department)}'][data-method='delete']"
        end
      end
    end

    should 'display' do
      visit admins_departments_path

      assert_selector '#main-content .card-header', text: I18n.t('views.department.name.plural')
      assert_selector "#main-content a[href='#{new_admins_department_path}']",
                      text: I18n.t('views.department.links.new')
    end
  end
end
