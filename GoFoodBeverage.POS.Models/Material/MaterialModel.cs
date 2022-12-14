using System;

namespace GoFoodBeverage.POS.Models.Material
{
    public class MaterialModel
    {
        public Guid Id { get; set; }

        public string Name { get; set; }

        public string Sku { get; set; }

        public int? Quantity { get; set; }

        public string UnitName { get; set; }

        public string Thumbnail { get; set; }
    }
}
