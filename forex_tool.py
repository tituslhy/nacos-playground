from nacos_mcp_wrapper.server.nacos_mcp import NacosMCP
from nacos_mcp_wrapper.server.nacos_settings import NacosSettings

import httpx

nacos_settings = NacosSettings()
nacos_settings.SERVER_ADDR = "127.0.0.1:8848" # <nacos_server_addr> e.g. 127.0.0.1:8848
nacos_settings.USERNAME=""
nacos_settings.PASSWORD=""
mcp = NacosMCP("nacos-mcp-python", nacos_settings=nacos_settings, port=18001)

@mcp.tool()
async def get_exchange_rate(
    currency_from: str = "USD",
    currency_to: str = "EUR",
):
    """Use this to get current exchange rate.

    Args:
        currency_from: The currency to convert from (e.g., "USD").
        currency_to: The currency to convert to (e.g., "EUR").

    Returns:
        A dictionary containing the exchange rate data, or an error message if the request fails.
    """    
    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(
                f"https://api.frankfurter.app/latest",
                params={"from": currency_from, "to": currency_to},
            )
            response.raise_for_status()

            data = response.json()
            if "rates" not in data:
                return {"error": "Invalid API response format."}
            return data
    except httpx.HTTPError as e:
        return {"error": f"API request failed: {e}"}
    except ValueError:
        return {"error": "Invalid JSON response from API."}

if __name__ == "__main__":
    print("🚀Starting server... ")
    mcp.run(transport="sse")