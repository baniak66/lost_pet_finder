ActiveAdmin.register Announcement do
  includes :user
  # show do
  #   # panel "Messages" do
  #   #   table_for announcement.messages do
  #   #     column :content

  #   #   end
  #   # end
  # end

show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end

      row "number of mess" do
        link_to "#{announcement.messages.count.to_s}", admin_announcement_messages_path(announcement)
      end
    end
  end


# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
