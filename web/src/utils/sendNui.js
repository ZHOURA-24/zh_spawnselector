import { isEnvBrowser } from "./misc";

export async function sendNui(eventName, data, debugReturn) {
    const options = {
        method: "post",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(data),
    };
    if (isEnvBrowser()) {
        alert(`Send Nui ${eventName} ${data}`)
        return Promise.resolve(debugReturn)
    }
    const resp = await fetch(`https://${GetParentResourceName()}/${eventName}`, options);
    return await resp.json()
}