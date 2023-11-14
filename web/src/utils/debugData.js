import { isEnvBrowser } from './misc';

export const debugData = (events, timer = 1000) => {
    if (isEnvBrowser()) {
        for (const event of events) {
            setTimeout(() => {
                window.dispatchEvent(
                    new MessageEvent('message', {
                        data: {
                            action: event.action,
                            data: event.data,
                        },
                    })
                );
            }, timer);
        }
    }
};
export default debugData;