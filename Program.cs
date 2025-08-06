using Prometheus;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseHttpMetrics(); // Collect metrics for HTTP requests

app.UseAuthorization();

app.MapRazorPages();

// 🎯 Prometheus endpoint
app.MapMetrics(); // Exposes /metrics

app.Run();
