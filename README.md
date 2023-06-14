# AI Chatbot for DNCEng Docs (PoC)
This repo contains the proof of concept code for a small-scaled demo that leverages Azure OpenAI to build a chatbot using .NET. The chatbot has the ability to answer DNCEng-based questions given documentation.

## How does it work
The solution involves integrating Azure Cognitive Search and the Azure OpenAI Service. The Azure Cognitive Search understands and retrieves data from the pdf documents stored in the "data" folder while the Azure OpenAI Service interacts in natural language to answer questions or take turns in a conversation. The way you interact with large language models like ChatGPT is using natural language, giving the model a “prompt” and requesting it to complete it.

## Resources
1. https://github.com/Azure-Samples/azure-search-openai-demo-csharp/
2. https://devblogs.microsoft.com/dotnet/transform-business-smart-dotnet-apps-azure-chatgpt/
3. https://learn.microsoft.com/en-us/azure/cognitive-services/openai/overview
4. https://learn.microsoft.com/en-us/azure/search/search-what-is-azure-search