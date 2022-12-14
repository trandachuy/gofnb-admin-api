using GoFoodBeverage.Domain.Entities;
using GoFoodBeverage.Interfaces.Repositories;
using GoFoodBeverage.Infrastructure.Contexts;

namespace GoFoodBeverage.Infrastructure.Repositories
{
    public class ThemeRepository : GenericRepository<Theme>, IThemeRepository
    {
        public ThemeRepository(GoFoodBeverageDbContext dbContext) : base(dbContext) { }
    }
}
