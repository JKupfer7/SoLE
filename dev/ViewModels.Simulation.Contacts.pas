unit ViewModels.Simulation.Contacts;

interface

uses
  Models.MainModel,
  ZDbcIntfs;

type
  TRiskyContact = class(TObject)
  private
  public
    class procedure InsertIntoDatabase(const AConnection: IZConnection; const
        AInfectiousPersonID, AContactPersonID, ARunDayID: String; const AContactTookPlace,
        AImmunityWorks, AInfectionTookPlace: Boolean);
  end;

implementation

{ TRiskyContact }

class procedure TRiskyContact.InsertIntoDatabase(const AConnection: IZConnection; const
    AInfectiousPersonID, AContactPersonID, ARunDayID: String; const AContactTookPlace,
    AImmunityWorks, AInfectionTookPlace: Boolean);
begin
  var Statement: IZPreparedStatement := AConnection.PrepareStatement(
    'INSERT INTO risky_contacts (contacts_id, simulation_run_day_id, infectious_person_id, ' +
    'contact_person_id, contact_took_place, immunity_works, infection_took_place) VALUES (?, ?, ?, ?, ?, ?, ?);');
  Statement.SetString(1, MainModel.GetPrimaryKeyValue);
  Statement.SetString(2, ARunDayID);
  Statement.SetString(3, AInfectiousPersonID);
  Statement.SetString(4, AContactPersonID);
  Statement.SetBoolean(5, AContactTookPlace);
  Statement.SetBoolean(6, AImmunityWorks);
  Statement.SetBoolean(7, AInfectionTookPlace);
  Statement.ExecutePrepared;
end;

end.
