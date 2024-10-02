import { icons } from "lucide-react";
import { cn } from "../lib/utils";
import Icon from "./icon";

export type DataProps = {
    label: string;
    description: string;
    image?: string;
    active?: boolean;
    disabled?: boolean;
    icon?: keyof typeof icons;
};

type CardProps = DataProps & React.HTMLAttributes<HTMLButtonElement>;

export const Card = ({ label, description, image, active, icon, ...props }: CardProps) => {
    return (
        <div className="flex flex-col gap-y-2">
            <div className="h-fit w-full border rounded flex flex-col relative bg-white/20">
                <div className="border-y p-4 flex items-center gap-x-4">
                    <div className="bg-zh-100 rotate-[45deg] p-1 rounded">
                        <Icon name={icon || "Map"} className="text-xl text-black -rotate-[45deg]" />
                    </div>
                    <div className="flex flex-col">
                        <h2 className="text-white">{label}</h2>
                        <p className="text-zh-100 text-xs">
                            {description}
                        </p>
                    </div>
                </div>
                {image && <img src={image} alt={label} className="w-full h-[150px] bg-cover bg-no-repeat bg-center" />}
            </div>
            <button
                {...props}
                className={cn("border py-2 rounded transition-all duration-500 bg-white/20", active && "bg-gradient-to-r from-zh-100 via-black to-zh-100 opacity-80")}
            >
                <p className="text-white text-center">{active ? "Spawn" : "View"}</p>
            </button>
        </div>
    );
};
