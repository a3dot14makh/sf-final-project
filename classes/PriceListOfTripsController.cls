public class PriceListOfTripsController {
    public String touristId;
    public List<Trip__c> trips { get; set; }
    public List<PriceBookEntry> prices { get; set; }

    public PriceListOfTripsController(ApexPages.StandardController stdController) {
        this.touristId = ApexPages.CurrentPage().getparameters().get('Id');
        this.trips = TouristAssignmentController.fetchTrips(touristId);

        Set<String> names = new Set<String>();

        for (Trip__c trip : trips) {
            names.add(trip.Name);
        }

        prices = PriceBookEntryManager.getByName(names);
    }
}
