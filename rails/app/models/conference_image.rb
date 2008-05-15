class Conference_image < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:conference_id]
  end

  def self.log_hidden_columns
    [:image]
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:conference,:id=>change.conference_id}
  end

  def self.log_change_title( change )
    Conference.log_change_title( Conference.select_single(:conference_id=>change.conference_id))
   rescue
    ""
  end

end

