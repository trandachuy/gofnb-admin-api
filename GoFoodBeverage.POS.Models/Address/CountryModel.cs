using System;

namespace GoFoodBeverage.POS.Models.Address
{
    public class CountryModel
    {
        public Guid Id { get; set; }

        public string Iso { get; set; }

        public string Name { get; set; }

        public string Nicename { get; set; }

        public string Numcode { get; set; }

        public string Phonecode { get; set; }
    }
}
