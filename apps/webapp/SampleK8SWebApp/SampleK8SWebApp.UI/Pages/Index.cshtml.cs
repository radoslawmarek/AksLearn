using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace SampleK8SWebApp.UI.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;
    public string NodeName { get; set; }
    public string PodName { get; set; }
    public string PodNamespace { get; set; }
    public string PodIp { get; set; }

    public IndexModel(ILogger<IndexModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        NodeName = Environment.GetEnvironmentVariable("NODE_NAME") ?? "Unknown";
        PodName = Environment.GetEnvironmentVariable("POD_NAME") ?? "Unknown";
        PodNamespace = Environment.GetEnvironmentVariable("POD_NAMESPACE") ?? "Unknown";
        PodIp = Environment.GetEnvironmentVariable("POD_IP") ?? "Unknown";
    }
}