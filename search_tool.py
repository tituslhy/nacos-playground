from dotenv import load_dotenv, find_dotenv
from langchain_tavily import TavilySearch
from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent

from acp_sdk import Message, MessagePart, Metadata
from acp_sdk.server import RunYield, RunYieldResume, Server

from typing import AsyncGenerator

_ = load_dotenv(find_dotenv())

# create agent
llm = ChatOpenAI(
    model="gpt-4o-mini",
    temperature=0,
    max_tokens=None,
    timeout=None,
    max_retries=2
)
search_tool = TavilySearch(max_results=5, topic="general")
agent = create_react_agent(model=llm, tools=[search_tool])

# serve the agent
server = Server()

@server.agent(
    name="tavily_search_agent",
    description="This agent searches the internet",
    metadata=Metadata(
        ui={
            "type": "chat",
            "user_greeting": "Hello! How can I help you today?"
        },  # type: ignore[call-arg]
        framework="LangGraph",
        recommended_models=["gpt-4o-mini"],
        author={
            "name": "Titus Lim",
            "email": "tituslhy@gmail.com",
        },
    ),
)
async def search_agent(
    input: list[Message]
) -> AsyncGenerator[RunYield, RunYieldResume]:
    
    query = str(input[-1])
    output = None
    
    async for chunk in agent.astream(
        {"messages": [{"role": "user", "content": query}]},
        stream_mode="updates"
    ):
        for value in chunk.items:
            yield {'update': value}
        
        output = chunk
        yield MessagePart(content=output.get("format_response", {}).get("final_response", ""))
        
if __name__ == "__main__":
    server.run(port=8000)