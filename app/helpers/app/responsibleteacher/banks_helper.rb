module App::Responsibleteacher::BanksHelper
  def approval(bank)
    if Approval.exists? timeline_id: bank.timeline_id
      approval = Approval.find_by(timeline_id: bank.timeline_id)
      link_to link_to glyph(:ok)+' '+approval.type_approval.name, '/'+approval.file, class: 'btn btn-xs btn-success'
    else
      nil
    end
  end
end