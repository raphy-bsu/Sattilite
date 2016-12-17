class AddAboutPage < ActiveRecord::Migration
  def up
    Page.create(title: 'About', slug: 'about', content: 'Change me at admin dashboard')
  end

  def down
    Page.find_by(slug: 'about').try(:destroy)
  end
end
